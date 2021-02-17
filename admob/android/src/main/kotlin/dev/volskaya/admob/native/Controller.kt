package dev.volskaya.admob.native

import android.content.Context
import android.os.AsyncTask
import android.util.Log
import dev.volskaya.admob.encodeError
import com.google.android.gms.ads.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdOptions
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.collections.ArrayList

class NativeAdmobBuilderTask(
        val controller: NativeAdmobController,
        val result: MethodChannel.Result,
        val context: Context,
        val unitId: String,
        private val options: Map<*, *>,
        private val callback: ((AdLoader) -> Unit)?
) : AsyncTask<Any?, Any?, AdLoader>() {
    override fun doInBackground(vararg params: Any?): AdLoader {
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

                    it.setMuteThisAdListener { controller.channel.invokeMethod("onAdMuted", null) }
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
                        controller.channel.invokeMethod("onAdFailedToLoad", encodeError(error))
                        result.success(false)
                    }

                    override fun onAdLoaded() {
                        super.onAdLoaded()
                        if (!controller.disposed) {
                            controller.nativeAd?.let { nativeAd ->
                                controller.nativeAdChanged?.let { it(nativeAd) }
                                controller.channel.invokeMethod("onAdLoaded", hashMapOf(
                                        "muteThisAdInfo" to hashMapOf(
                                                "muteThisAdReasons" to nativeAd.muteThisAdReasons?.map { it.description } as List<String>,
                                                "isCustomMuteThisAdEnabled" to nativeAd.isCustomMuteThisAdEnabled
                                        ),
                                        "mediaContent" to hashMapOf(
                                                "duration" to nativeAd.mediaContent.duration.toDouble(),
                                                "aspectRatio" to nativeAd.mediaContent.aspectRatio.toDouble(),
                                                "hasVideoContent" to nativeAd.mediaContent.hasVideoContent()
                                        )
                                ))
                            }
                        } else {
                            controller.nativeAd?.destroy()
                        }
                        result.success(true)
                    }
                })
                .withNativeAdOptions(adOptions.build())
                .build()

        Log.d("NativeAdController", "Constructed NativeAd builders in ${System.currentTimeMillis() - timestamp} ms")

        loader.loadAd(AdRequest.Builder().build())
        Log.d("NativeAdController", "Loaded NativeAd with a builder in ${System.currentTimeMillis() - timestamp} ms")

        return loader
    }

    override fun onPostExecute(result: AdLoader?) {
        super.onPostExecute(result)
        callback?.let { postExecuteCallback -> result?.let { postExecuteCallback(it) } }
    }
}

class NativeAdmobController(
    val id: String,
    val channel: MethodChannel,
    private val context: Context
) : MethodChannel.MethodCallHandler {
    var disposed: Boolean = false

    var nativeAdChanged: ((NativeAd?) -> Unit)? = null
    var nativeAdUpdateRequested: ((Map<String, Any?>, NativeAd?) -> Unit)? = null
    var nativeAd: NativeAd? = null

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "loadAd" -> {
                val unitId = call.argument<String>("unitId") ?: "ca-app-pub-3940256099942544/2247696110"
                val options = call.argument<Map<String, Any>>("options")
                loadAd(unitId, options!!, result)
            }
            "updateUI" -> {
                val data = call.argument<Map<String, Any?>>("layout") ?: return
                nativeAdUpdateRequested?.let { it(data, nativeAd) }
                result.success(null)
            }
            "muteAd" -> {
                nativeAd?.let {
                   if (it.isCustomMuteThisAdEnabled) it.muteThisAd(it.muteThisAdReasons[call.argument<Int>("reason")!!])
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    fun undefined() {
        channel.invokeMethod("undefined", null)
    }

    fun dispose() {
        disposed = true
        nativeAd?.destroy()
    }

    private fun loadAd(unitId: String, options: Map<String, Any>, result: MethodChannel.Result) {
        channel.invokeMethod("loading", null)

        val task = NativeAdmobBuilderTask(this, result, context, unitId, options) {
//            val timestamp = System.currentTimeMillis()
//            it.loadAd(AdRequest.Builder().build())
//            Log.d("NativeAdController", "Loaded NativeAd with a builder in ${System.currentTimeMillis() - timestamp} ms")
        }

        task.execute()

        // Build the options.
//        val timestamp = System.currentTimeMillis()
//        val videoOptions = options["videoOptions"] as? Map<*, *>
//        val adVideoOptions = VideoOptions.Builder().setStartMuted((videoOptions?.get("startMuted") as? Boolean) ?: true)
//        val adOptions = NativeAdOptions.Builder()
//                .setReturnUrlsForImageAssets(options["returnUrlsForImageAssets"] as Boolean)
//                .setRequestMultipleImages(options["requestMultipleImages"] as Boolean)
//                .setAdChoicesPlacement(options["adChoicesPlacement"] as Int)
//                .setMediaAspectRatio(options["mediaAspectRatio"] as Int)
//                .setRequestCustomMuteThisAd(options["requestCustomMuteThisAd"] as Boolean)
//                .setVideoOptions(adVideoOptions.build())
//
//        // Build the ad.
//        val loader = AdLoader.Builder(context, unitId)
//                .forNativeAd {
//                    nativeAd = it
//                    val now = System.currentTimeMillis()
//
//                    it.setMuteThisAdListener { channel.invokeMethod("onAdMuted", null) }
//                    if (it.mediaContent.hasVideoContent()) {
//                        it.mediaContent.videoController.videoLifecycleCallbacks = object : VideoController.VideoLifecycleCallbacks() {
//                            override fun onVideoStart() { channel.invokeMethod("onVideoStart", null) }
//                            override fun onVideoPlay() { channel.invokeMethod("onVideoPlay", null) }
//                            override fun onVideoPause() { channel.invokeMethod("onVideoPause", null) }
//                            override fun onVideoEnd() { channel.invokeMethod("onVideoEnd", null) }
//                            override fun onVideoMute(isMuted: Boolean) { channel.invokeMethod("onVideoMute", isMuted) }
//                        }
//                    }
//
//                    Log.d("NativeAdController", "Attached listeners for NativeAd ${nativeAd.hashCode()} in ${ System.currentTimeMillis() - now} ms")
//                }
//                .withAdListener(object : AdListener() {
//                    override fun onAdFailedToLoad(error: LoadAdError) {
//                        super.onAdFailedToLoad(error)
//                        channel.invokeMethod("onAdFailedToLoad", encodeError(error))
//                        result.success(false)
//                    }
//
//                    override fun onAdLoaded() {
//                        super.onAdLoaded()
//                        if (!disposed) {
//                            nativeAdChanged?.let { it(nativeAd) }
//                            val mediaContent = nativeAd!!.mediaContent
//                            channel.invokeMethod("onAdLoaded", hashMapOf(
//                                    "muteThisAdInfo" to hashMapOf(
//                                            "muteThisAdReasons" to nativeAd!!.muteThisAdReasons?.map { it.description } as List<String>,
//                                            "isCustomMuteThisAdEnabled" to nativeAd!!.isCustomMuteThisAdEnabled
//                                    ),
//                                    "mediaContent" to hashMapOf(
//                                            "duration" to mediaContent.duration.toDouble(),
//                                            "aspectRatio" to mediaContent.aspectRatio.toDouble(),
//                                            "hasVideoContent" to mediaContent.hasVideoContent()
//                                    )
//                            ))
//                        } else {
//                            nativeAd?.destroy()
//                        }
//                        result.success(true)
//                    }
//                })
//                .withNativeAdOptions(adOptions.build())
//                .build()
//        Log.d("NativeAdController", "Constructed NativeAd builders in ${System.currentTimeMillis() - timestamp} ms")
//
//        loader.loadAd(AdRequest.Builder().build())
//        Log.d("NativeAdController", "Loaded NativeAd with a builder in ${System.currentTimeMillis() - timestamp} ms")
    }
}

object NativeAdmobControllerManager {
    private val controllers: ArrayList<NativeAdmobController> = arrayListOf()

    fun createController(id: String, binaryMessenger: BinaryMessenger, context: Context) {
        if (getController(id) == null) {
            val methodChannel = MethodChannel(binaryMessenger, id)
            val controller = NativeAdmobController(id, methodChannel, context)
            controllers.add(controller)
        }
    }

    fun getController(id: String): NativeAdmobController? {
        return controllers.firstOrNull { it.id == id }
    }

    fun removeController(id: String) {
        val index = controllers.indexOfFirst { it.id == id }
        val controller = if (index >= 0) controllers.removeAt(index) else null
        controller?.dispose()
    }
}
