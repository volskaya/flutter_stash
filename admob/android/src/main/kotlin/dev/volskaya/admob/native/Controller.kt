package dev.volskaya.admob.native

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.os.AsyncTask
import android.util.Log
import com.google.android.gms.ads.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdOptions
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.*

@SuppressLint("StaticFieldLeak")
class NativeAdmobBuilderTask(
        val controller: NativeAdmobController,
        private val context: Context, // Expects the application context.
        private val unitId: String,
        private val options: Map<*, *>,
        private val onLoaded: (NativeAd?) -> Unit
) : AsyncTask<Any?, Any?, Any?>() {
    override fun doInBackground(vararg params: Any?) {
        val videoOptions = options["videoOptions"] as? Map<*, *>
        val adVideoOptions = VideoOptions.Builder().setStartMuted((videoOptions?.get("startMuted") as? Boolean) ?: true)
        val adOptions = NativeAdOptions.Builder()
                .setReturnUrlsForImageAssets(options["returnUrlsForImageAssets"] as Boolean)
                .setRequestMultipleImages(options["requestMultipleImages"] as Boolean)
                .setAdChoicesPlacement(options["adChoicesPlacement"] as Int)
                .setMediaAspectRatio(options["mediaAspectRatio"] as Int)
                .setRequestCustomMuteThisAd(options["requestCustomMuteThisAd"] as Boolean)
                .setVideoOptions(adVideoOptions.build())

        // Build and load the ad.
        AdLoader.Builder(context, unitId)
                .forNativeAd {
                    controller.nativeAd = it

                    it.setMuteThisAdListener { controller.channel.invokeMethod("onAdMuted", it.muteThisAdReasons.map { reasons -> reasons.description }) }
                    if (controller.showVideoContent && it.mediaContent.hasVideoContent()) {
                        it.mediaContent.videoController.videoLifecycleCallbacks = object : VideoController.VideoLifecycleCallbacks() {
                            override fun onVideoStart() { controller.channel.invokeMethod("onVideoStart", null) }
                            override fun onVideoPlay() { controller.channel.invokeMethod("onVideoPlay", null) }
                            override fun onVideoPause() { controller.channel.invokeMethod("onVideoPause", null) }
                            override fun onVideoEnd() { controller.channel.invokeMethod("onVideoEnd", null) }
                            override fun onVideoMute(isMuted: Boolean) { controller.channel.invokeMethod("onVideoMute", isMuted) }
                        }
                    }
                }
                .withAdListener(object : AdListener() {
                    override fun onAdFailedToLoad(error: LoadAdError) {
                        super.onAdFailedToLoad(error)
                        onLoaded(null)
                    }

                    override fun onAdLoaded() {
                        super.onAdLoaded()
                        onLoaded(controller.nativeAd)
                    }
                })
                .withNativeAdOptions(adOptions.build())
                .build()
                .loadAd(AdRequest.Builder().build())
    }
}

class NativeAdmobController(
        val id: String,
        val channel: MethodChannel,
        private val activity: Activity,
        val showVideoContent: Boolean
) : MethodChannel.MethodCallHandler {
    companion object {
        private val controllers: HashMap<String, NativeAdmobController> = hashMapOf()

        fun get(id: String): NativeAdmobController? { return controllers[id] }
        fun create(id: String, binaryMessenger: BinaryMessenger, activity: Activity, showVideoContent: Boolean): NativeAdmobController {
            val methodChannel = MethodChannel(binaryMessenger, id)
            val controller = NativeAdmobController(id, methodChannel, activity, showVideoContent)
            controllers[id] = controller
            return controller
        }
    }

    private val preferPlatformView: Boolean
        get() { return showVideoContent && nativeAd?.mediaContent?.hasVideoContent() == true }

    var shouldMountGhostView: Boolean = false // Toggled by Flutter, when it wants the ghost view active
    var disposed: Boolean = false
    var nativeAd: NativeAd? = null
    var ghostView: NativeAdGhostView? = null
    var platformView: NativeAdMediaView? = null
        set(value) {
            if (platformView != null) throw Error("This controller should have never received another platform view")
            field = value

            // If this controller prefers the platform view, but it was not ready, when Flutter
            // called `shouldMountGhostView`, it needs to be created here.
            //
            // If the field was set to null, make sure the ghost view is disposed.
            if (preferPlatformView) field?.let { mountGhostView() } ?: unmountGhostView(true)
        }

    init {
        channel.setMethodCallHandler(this)
    }

    // The ghost view can be forcefully unmounted, for example when the platform view has to dispose.
    private fun unmountGhostView(force: Boolean = false) {
        if (!force && shouldMountGhostView) return // Flutter app still expects the view to be mounted.
        Log.d("Napy", "Unmounting ghost view $ghostView")
        ghostView?.dispose()?.also { ghostView = null }
    }

    // Attempts to mount a ghost view, if an ad exists. If the controller prefers the platform
    // view, uses the platform variant of ghost view instead, which might not be ready yet - the
    // ghost view wouldn't be built.
    //
    // Ghost views should only be mounted, when the Flutter app has received and reacted to a native ad.
    private fun mountGhostView() {
        if (!shouldMountGhostView) return

        // This should not happen, but clean up the existing ghost view.
        ghostView?.dispose()?.also { ghostView = null }

        if (preferPlatformView) {
            platformView?.nativeAdView?.let { ghostView = NativeAdGhostView().also { ghost -> ghost.mountExistingView(it) } }
        } else {
            nativeAd?.let { nativeAd -> ghostView = NativeAdGhostView().also { it.mount(activity, nativeAd) } }
        }

        Log.d("Napy", "Mounted ghost view $ghostView")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "mountView" -> {
                shouldMountGhostView = true
                mountGhostView()
                result.success(null)
            }
            "unmountView" -> {
                shouldMountGhostView = false
                unmountGhostView()
                result.success(null)
            }
            "click" -> result.success(ghostView?.click() ?: false)
            "load" -> {
                val unitId = call.argument<String>("unitId") ?: "ca-app-pub-3940256099942544/2247696110"
                val options = call.argument<Map<String, Any>>("options")
                loadAd(unitId, options!!, result)
            }
            "mute" -> {
                nativeAd?.let { if (it.isCustomMuteThisAdEnabled) it.muteThisAd(it.muteThisAdReasons[call.argument<Int>("reason")!!]) }
                result.success(null)
            }
            "dispose" -> {
                controllers.remove(id)
                dispose()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun dispose() {
        disposed = true
        shouldMountGhostView = false
        unmountGhostView(true)
        nativeAd?.destroy()?.also { nativeAd = null }
    }

    private fun loadAd(unitId: String, options: Map<String, Any>, result: MethodChannel.Result) {
        channel.invokeMethod("onAdLoading", null)
        (NativeAdmobBuilderTask(this, activity.applicationContext, unitId, options) {
            val response = it?.toFlutterMap() ?: hashMapOf( "runtimeType" to "error", "message" to "NativeAd is null" )
            if (!disposed) { channel.invokeMethod("onAdChanged", response) } else { nativeAd?.destroy() }
            result.success(response)
        }).execute()
    }
}

fun Drawable.toBitmapByteArray(): ByteArray {
    val bitmap = Bitmap.createBitmap(this.intrinsicWidth, this.intrinsicHeight, Bitmap.Config.ARGB_8888)
    this.draw(Canvas(bitmap))

    // Convert bitmap to bytes.
    val stream = ByteArrayOutputStream()
    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream)
    val byteArray: ByteArray = stream.toByteArray()
    bitmap.recycle()

    return byteArray
}

fun NativeAd.Image.toFlutterMap(drawBitmap: Boolean = false): Map<*, *> {
    return hashMapOf(
            "uri" to this.uri.toString(),
            "scale" to this.scale,
            "drawable" to if (drawBitmap) (this.drawable?.let {
                // Flutter units don't have density applied, but native android does.
                val density = Resources.getSystem().displayMetrics.density

                hashMapOf<String, Any?>(
                        "width" to it.intrinsicWidth / density,
                        "height" to it.intrinsicWidth / density,
                        "bitmap" to  it.toBitmapByteArray()
                )
            }) else null
    )
}

fun NativeAd.toFlutterMap(): Map<*, *> {
    return hashMapOf(
            "runtimeType" to "default",
            "advertiser" to this.advertiser,
            "body" to this.body,
            "headline" to this.headline,
            "price" to this.price,
            "store" to this.store,
            "callToAction" to this.callToAction,
            "starRating" to this.starRating?.toDouble(),
            "icon" to this.icon?.toFlutterMap(),
            "images" to this.images?.map { image -> image.toFlutterMap() },
            "isCustomClickGestureEnabled" to this.isCustomClickGestureEnabled,
            "isCustomMuteThisAdEnabled" to this.isCustomMuteThisAdEnabled,
            "muteThisAdReasons" to this.muteThisAdReasons?.map { it.description },
            "mediaContent" to hashMapOf(
                    "aspectRatio" to this.mediaContent.aspectRatio.toDouble(),
                    "hasVideoContent" to this.mediaContent.hasVideoContent(),
                    "duration" to this.mediaContent.duration.toDouble()
//                    "mainImage" to this.mediaContent.mainImage?.toBitmapByteArray(),
            ),
            "adChoicesInfo" to hashMapOf(
                    "text" to this.adChoicesInfo.text?.toString(),
                    "images" to this.adChoicesInfo.images.map { image -> image.toFlutterMap() }
            )
    )
}

