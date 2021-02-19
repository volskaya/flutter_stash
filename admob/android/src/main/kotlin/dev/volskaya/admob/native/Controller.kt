package dev.volskaya.admob.native

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.os.AsyncTask
import android.os.Build
import android.util.Log
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.asynclayoutinflater.view.AsyncLayoutInflater
import com.google.android.gms.ads.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdOptions
import com.google.android.gms.ads.nativead.NativeAdView
import dev.volskaya.admob.*
import dev.volskaya.admob.R
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.lang.annotation.Native

class NativeAdmobBuilderTask(
        val controller: NativeAdmobController,
        val result: MethodChannel.Result,
        @SuppressLint("StaticFieldLeak") private val context: Context, // Expects the application context.
        private val unitId: String,
        private val options: Map<*, *>
) : AsyncTask<Any?, Any?, Any?>() {
    override fun doInBackground(vararg params: Any?) {
        val timestamp = System.currentTimeMillis()
        val videoOptions = options["videoOptions"] as? Map<*, *>
        val adVideoOptions = VideoOptions.Builder().setStartMuted((videoOptions?.get("startMuted") as? Boolean) ?: true)
        val adOptions = NativeAdOptions.Builder()
                .setReturnUrlsForImageAssets(options["returnUrlsForImageAssets"] as Boolean)
                .setRequestMultipleImages(options["requestMultipleImages"] as Boolean)
                .setAdChoicesPlacement(options["adChoicesPlacement"] as Int)
                .setMediaAspectRatio(options["mediaAspectRatio"] as Int)
                .setRequestCustomMuteThisAd(options["requestCustomMuteThisAd"] as Boolean)
                .setVideoOptions(adVideoOptions.build())

        // Build the ad.
        val loader = AdLoader.Builder(context, unitId)
                .forNativeAd {
                    controller.nativeAd = it
                    val now = System.currentTimeMillis()

                    it.setMuteThisAdListener { controller.channel.invokeMethod("onAdMuted", it.muteThisAdReasons.map { reasons -> reasons.description }) }
                    if (it.mediaContent.hasVideoContent()) {
                        it.mediaContent.videoController.videoLifecycleCallbacks = object : VideoController.VideoLifecycleCallbacks() {
                            override fun onVideoStart() { controller.channel.invokeMethod("onVideoStart", null) }
                            override fun onVideoPlay() { controller.channel.invokeMethod("onVideoPlay", null) }
                            override fun onVideoPause() { controller.channel.invokeMethod("onVideoPause", null) }
                            override fun onVideoEnd() { controller.channel.invokeMethod("onVideoEnd", null) }
                            override fun onVideoMute(isMuted: Boolean) { controller.channel.invokeMethod("onVideoMute", isMuted) }
                        }
                    }

                    Log.d("NativeAdController", "Attached listeners for NativeAd ${it.hashCode()} in ${ System.currentTimeMillis() - now} ms")
                }
                .withAdListener(object : AdListener() {
                    override fun onAdFailedToLoad(error: LoadAdError) {
                        super.onAdFailedToLoad(error)
                        val response = hashMapOf(
                                "runtimeType" to "error",
                                "message" to encodeError(error)
                        )

                        controller.channel.invokeMethod("onAdChanged", response)
                        result.success(response)
                    }

                    override fun onAdLoaded() {
                        super.onAdLoaded()

                        val response = controller.nativeAd?.toFlutterMap() ?: hashMapOf(
                                "runtimeType" to "error",
                                "message" to "NativeAd is null"
                        )

                        if (!controller.disposed) {
                            controller.channel.invokeMethod("onAdChanged", response)
                        } else {
                            controller.nativeAd?.destroy()
                        }

                        result.success(response)
                    }
                })
                .withNativeAdOptions(adOptions.build())
                .build()

        Log.d("NativeAdController", "Constructed NativeAd builders in ${System.currentTimeMillis() - timestamp} ms")

        loader.loadAd(AdRequest.Builder().build())
        Log.d("NativeAdController", "Loaded NativeAd with a builder in ${System.currentTimeMillis() - timestamp} ms")
    }
}

class NativeAdmobController(
    val id: String,
    val channel: MethodChannel,
    private val activity: Activity
) : MethodChannel.MethodCallHandler {
    companion object {
        const val tag = "NativeAdmobController"
    }

    private val contentView = activity.window.decorView.findViewById<ViewGroup>(android.R.id.content)
    private val contentViewParent = contentView.parent as ViewGroup

    var disposed: Boolean = false
    var mountView: Boolean = false

    var backgroundView: NativeAdView? = null
    var nativeAdChanged: ((NativeAd?) -> Unit)? = null
    var nativeAd: NativeAd? = null

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "mountView" -> {
                Log.d(tag, "Mount view called")
                mountView = true
                nativeAd?.let { nativeAd ->
                    AsyncLayoutInflater(activity).inflate(R.layout.background_native_ad, contentViewParent) { inflatedView, resid, parent ->
                        val view = (inflatedView as NativeAdView)

                        if (mountView) {
                            parent?.let { parent ->
                                view.headlineView = view.findViewById<TextView>(R.id.background_native_ad_view_headline).also { it.text = nativeAd.headline }
                                view.bodyView = view.findViewById<TextView>(R.id.background_native_ad_view_body).also { it.text = nativeAd.body }
                                view.callToActionView = view.findViewById<Button>(R.id.background_native_ad_view_button).also { it.text = nativeAd.callToAction }
                                view.setNativeAd(nativeAd)

                                parent.addView(view, 0)
                                backgroundView = view
                            } ?: view.destroy()

                            if (parent == null) { Log.d(tag, "Parent is null") }
                        } else {
                            view.destroy()
                        }
                    }
                }
                result.success(null)
            }
            "unmountView" -> {
                Log.d(tag, "Unmount view called")

                mountView = false
                // NOTE: Also calling .destroy() on the NativeAdView prevented its exposure from being logged.
                backgroundView?.let { contentViewParent.removeView(it) }
                result.success(null)
            }
            "click" -> {
                val click = (backgroundView?.callToActionView as? Button)?.performClick() ?: false
                result.success(click)
            }
            "load" -> {
                val unitId = call.argument<String>("unitId") ?: "ca-app-pub-3940256099942544/2247696110"
                val options = call.argument<Map<String, Any>>("options")
                loadAd(unitId, options!!, result)
            }
            "mute" -> {
                nativeAd?.let {
                   if (it.isCustomMuteThisAdEnabled) it.muteThisAd(it.muteThisAdReasons[call.argument<Int>("reason")!!])
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    fun dispose() {
        backgroundView?.destroy()
        mountView = false
        disposed = true
        nativeAd?.destroy()
    }

    private fun loadAd(unitId: String, options: Map<String, Any>, result: MethodChannel.Result) {
        channel.invokeMethod("onAdLoading", null)
        NativeAdmobBuilderTask(this, result, activity, unitId, options).execute()
    }
}

object NativeAdmobControllerManager {
    private val controllers: HashMap<String, NativeAdmobController> = hashMapOf()

    fun createController(id: String, binaryMessenger: BinaryMessenger, activity: Activity) {
        if (!controllers.containsKey(id)) {
            val methodChannel = MethodChannel(binaryMessenger, id)
            val controller = NativeAdmobController(id, methodChannel, activity)
            controllers[id] = controller
        }
    }

    fun getController(id: String): NativeAdmobController? { return controllers[id] }
    fun removeController(id: String) { controllers.remove(id)?.dispose() }
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

fun NativeAd.Image.toFlutterMap(): Map<*, *> {
    // Flutter units don't have density applied, but native android does.
    val density = Resources.getSystem().displayMetrics.density

    return hashMapOf(
            "uri" to this.uri.toString(),
            "scale" to this.scale,
            "drawable" to (this.drawable?.let {
                hashMapOf<String, Any?>(
                        "width" to it.intrinsicWidth / density,
                        "height" to it.intrinsicWidth / density,
                        "bitmap" to it.toBitmapByteArray()
                )
            })
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
            "adChoicesInfo" to hashMapOf<String, Any?>(
                    "text" to this.adChoicesInfo.text,
                    "images" to this.adChoicesInfo.images.map { image -> image.toFlutterMap() }
            )
    )
}

