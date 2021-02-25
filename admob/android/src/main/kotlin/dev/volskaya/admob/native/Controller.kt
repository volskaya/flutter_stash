package dev.volskaya.admob.native

import android.app.Activity
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.util.Log
import com.google.android.gms.ads.VideoController
import com.google.android.gms.ads.nativead.NativeAd
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.*

class NativeAdmobController(
        private val id: String,
        private var channel: MethodChannel?,
        private val activity: Activity,
        private val loader: NativeAdLoader
) : MethodChannel.MethodCallHandler {
    companion object {
        private val controllers: HashMap<String, NativeAdmobController> = hashMapOf()

        fun get(id: String): NativeAdmobController? { return controllers[id] }
        fun create(id: String, binaryMessenger: BinaryMessenger, activity: Activity, loader: NativeAdLoader): NativeAdmobController {
            return NativeAdmobController(id, MethodChannel(binaryMessenger, id), activity, loader).also { controllers[id] = it }
        }

        fun hydrateFirstController(key: String, nativeAd: NativeAd?): Boolean {
            Log.d(null, "Attempting to hydrate first available controller")

            for (controller in controllers.values) {
                if (controller.loader.key == key && !controller.hydrated) {
                    // Hydrate returns false, if the controller didn't end using the ad.
                    // In that case continue on to the next controller, if any.
                    if (controller.hydrate(nativeAd)) {
                        Log.d(null, "Hydrating controller ${controller.id} of $key")
                        return true
                    }
                }
            }

            Log.d(null, "Didn't find a controller of $key to hydrate")
            return false // Add was consumed and should be removed from the NativeAdLoader's pool.
        }
    }

    private val preferPlatformView: Boolean
        get() = showVideoContent && nativeAd?.mediaContent?.hasVideoContent() == true
    private val disposed: Boolean
        get() = channel == null

    private var shouldMountGhostView: Boolean = false // Toggled by Flutter, when it wants the ghost view active
    private var ghostView: NativeAdGhostView? = null
    val showVideoContent: Boolean = loader.showVideoContent
    var hydrated: Boolean = false
    var nativeAd: NativeAd? = null
    var platformView: NativeAdMediaView? = null
        set(value) {
            if (platformView != null) Log.w(null, "Controller $id received a redundant platform view")
            field = value

            // If this controller prefers the platform view, but it was not ready, when Flutter
            // called `shouldMountGhostView`, it needs to be created here.
            //
            // If the field was set to null, make sure the ghost view is disposed.
            if (preferPlatformView) field?.let { mountGhostView() } ?: unmountGhostView(true)
        }

    init {
        channel?.setMethodCallHandler(this)
    }

    // Tries to hydrate with the first available pooled ad or requests the loader to load more ads.
    private fun attemptToHydrate() {
        if (disposed) { Log.w(null, "Controller $id attempted to hydrate while disposed"); return }
        if (hydrated) { Log.w(null, "Controller $id attempted a redundant hydrate"); return }

        loader.getPooledNativeAd()?.let {
            val didHydrate = hydrate(it.value)

            // Usually the controller shouldn't fail to hydrate, because it wouldn't yet be disposed
            // in the constructor.
            if (!didHydrate) {
                Log.w(null, "Controller $id failed to hydrate a pooled ad on init")
                it.destroy()
            } else {
                Log.d(null, "Controller $id init hydrated an existing ad")
            }
        } ?: let {
            Log.d(null, "Controller $id init didn't find a pooled ad to hydrate, requesting a new one from ${loader.key}")
            loader.loadNext() // If no ad was available, request one for the loader and it will eventually hydrate this controller.
        }
    }

    // Hydrates the controller with an ad. Returns false, if the controller didn't end up consuming
    // the NativeAd, for example if it was disposed.
    fun hydrate(nativeAd: NativeAd?): Boolean {
        if (disposed) { Log.w(null, "Controller $id was hydrated while disposed"); return false }
        if (hydrated) { Log.w(null, "Controller $id received a redundant hydrate"); return false }

        hydrated = true

        return channel?.let { channel ->
            val response = nativeAd?.toFlutterMap() ?: hashMapOf( "runtimeType" to "error", "message" to "NativeAd is null" )
            channel.invokeMethod("onAdChanged", response)

            // Attach listeners to the new ad and assign it to the controller.
            this.nativeAd = nativeAd?.let {
                it.setMuteThisAdListener { channel.invokeMethod("onAdMuted", it.muteThisAdReasons.map { reasons -> reasons.description }) }
                if (showVideoContent && it.mediaContent.hasVideoContent()) {
                    it.mediaContent.videoController.videoLifecycleCallbacks = object : VideoController.VideoLifecycleCallbacks() {
                        override fun onVideoStart() { channel.invokeMethod("onVideoStart", null) }
                        override fun onVideoPlay() { channel.invokeMethod("onVideoPlay", null) }
                        override fun onVideoPause() { channel.invokeMethod("onVideoPause", null) }
                        override fun onVideoEnd() { channel.invokeMethod("onVideoEnd", null) }
                        override fun onVideoMute(isMuted: Boolean) { channel.invokeMethod("onVideoMute", isMuted) }
                    }
                }

                it // Assign the ad to the controller.
            }

            true // Hydrated.
        } ?: false // Not hydrated.
    }


    // The ghost view can be forcefully unmounted, for example when the platform view has to dispose.
    private fun unmountGhostView(force: Boolean = false) {
        if (!force && shouldMountGhostView) return // Flutter app still expects the view to be mounted.
        ghostView?.dispose()?.also {
            Log.d(null, "Unmounted ghost view $ghostView")
            ghostView = null
        }
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

        Log.d(null, "Mounted ghost view $ghostView")
    }

    private fun dispose() {
        channel = null
        shouldMountGhostView = false
        unmountGhostView(true)
        nativeAd?.destroy()?.also { nativeAd = null }
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
            "hydrate" -> attemptToHydrate().also { result.success(null) }
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

