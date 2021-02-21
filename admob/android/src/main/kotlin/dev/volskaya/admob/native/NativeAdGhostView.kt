package dev.volskaya.admob.native

import android.app.Activity
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.asynclayoutinflater.view.AsyncLayoutInflater
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.volskaya.admob.R

class NativeAdGhostView {
    private var view: NativeAdView? = null
    private var mounted: Boolean = true
    private var removeOnDispose: Boolean = true // When mounted with an existing view, don't remove on dispose.

    fun mountExistingView(existingView: NativeAdView) {
        if (!mounted) throw Error("This ghost view should not be mounted again")
        removeOnDispose = false
        view = existingView
    }

    fun mount(activity: Activity, nativeAd: NativeAd) {
        if (!mounted) throw Error("This ghost view should not be mounted again")
        AsyncLayoutInflater(activity).inflate(
                R.layout.background_native_ad,
                activity.window.decorView.findViewById(android.R.id.content)
        ) { inflatedView, _, viewParent ->
            val view = (inflatedView as NativeAdView)

            if (mounted) {
                viewParent?.let { parent ->
                    view.headlineView = view.findViewById<TextView>(R.id.background_native_ad_view_headline).also { it.text = nativeAd.headline }
                    view.bodyView = view.findViewById<TextView>(R.id.background_native_ad_view_body).also { it.text = nativeAd.body }
                    view.callToActionView = view.findViewById<Button>(R.id.background_native_ad_view_button).also { it.text = nativeAd.callToAction }
                    view.setNativeAd(nativeAd)

                    parent.addView(view, 0)
                    this.view = view
                } ?: view.destroy()
            } else {
                view.destroy()
            }
        }
    }

    fun dispose() {
        mounted = false
        
        if (removeOnDispose) {
            view?.let {
                (it.parent as ViewGroup).removeView(it)
                view = null
            }
        }
    }

    fun click(): Boolean {
         return (view?.callToActionView as? Button)?.callOnClick() ?: false
    }
}