package dev.volskaya.admob.native

import android.content.Context
import android.util.Log
import com.google.android.gms.ads.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdOptions

class PooledNativeAd(val value: NativeAd) {
    companion object {
        const val timeoutDuration: Long = 60 * 60 * 1000 // 1 hour in ms.
    }

    private val poolTime: Long = System.currentTimeMillis()

    fun considerOld(): Boolean {
        return (poolTime + timeoutDuration) < System.currentTimeMillis()
    }

    fun destroy() {
        value.destroy()
    }
}

class NativeAdLoader(context: Context, unitId: String, options: Map<*, *>) {
    private val loader: AdLoader
    private val request = AdRequest.Builder().build()
    private val pool: MutableList<PooledNativeAd> = mutableListOf()

    val showVideoContent: Boolean = options["showVideoContent"] as? Boolean ?: true

    init {
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
        loader = AdLoader.Builder(context, unitId)
                .forNativeAd { pool.add(PooledNativeAd(it)) }
                .withAdListener(object : AdListener() {
                    override fun onAdFailedToLoad(error: LoadAdError) {
                        super.onAdFailedToLoad(error)

                        Log.d(null, "Ad loaded failed, hydrating a controller with a null ad")
                        NativeAdmobController.hydrateFirstController(null) // Simulate "No ad found".
                    }

                    override fun onAdLoaded() {
                        super.onAdLoaded()

                        Log.d(null, "Ad loaded, attempting to hydrate from ${pool.size} pooled ads")
                        getPooledNativeAd()?.let {
                            val didConsumeAd = NativeAdmobController.hydrateFirstController(it.value)
                            if (!didConsumeAd) {
                                Log.d(null, "Couldn't find a controller for an ad, adding $it back to the pool")
                                pool.add(0, it)
                            } // The ad didn't get consumed, add it back to the pool.
                        }
                    }
                })
                .withNativeAdOptions(adOptions.build())
                .build()

    }

    fun loadNext() {
        Log.d(null, "Requesting to load another ad")
        if (!loader.isLoading) loader.loadAds(request, 5)
    }

    fun getPooledNativeAd(): PooledNativeAd? {
        while (pool.isNotEmpty()) {
            val firstPooledNativeAd = pool.removeAt(0)
            if (!firstPooledNativeAd.considerOld()) {
                return firstPooledNativeAd
            } else {
                Log.d(null, "$firstPooledNativeAd can be considered old, destroying it")
                firstPooledNativeAd.destroy()
            }
        }

        return null
    }
}