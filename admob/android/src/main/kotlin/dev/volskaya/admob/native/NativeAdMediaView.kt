package dev.volskaya.admob.native

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAdView
import dev.volskaya.admob.R
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeAdMediaViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return NativeAdMediaView(context, args as Map<*, *>)
    }
}

@SuppressLint("InflateParams")
class NativeAdMediaView(context: Context, data: Map<*, *>) : PlatformView {
    private val controllerId: String = data["controllerId"] as String
    private val controller: NativeAdmobController? = NativeAdmobController.get(controllerId)
    private val view: ViewGroup = controller?.nativeAd?.let { nativeAd ->
        (LayoutInflater.from(context).inflate(R.layout.video_native_ad, null) as? FrameLayout)?.also { parent ->
            parent.findViewById<NativeAdView>(R.id.video_native_ad_view)?.let {
                it.headlineView = it.findViewById<TextView>(R.id.video_native_ad_view_headline).also { textView -> textView.text = nativeAd.headline }
                it.bodyView = it.findViewById<TextView>(R.id.video_native_ad_view_body).also { textView -> textView.text = nativeAd.body }
                it.mediaView = it.findViewById<MediaView>(R.id.video_native_ad_view_media).also { mediaView -> mediaView.setMediaContent(nativeAd.mediaContent) }
                it.callToActionView = it.findViewById<Button>(R.id.video_native_ad_view_button).also { button -> button.text = nativeAd.callToAction }
                it.setNativeAd(nativeAd)

                if (controller.view == null) {
                    // Assign the ghost view on the NativeAdController to allow it to call click events.
                    controller.view = it
                } else {
                    Log.w("Napy", "NativeAdMediaView wasn't assigned as NativeAdController's ghost view, it already has one")
                }
            }
        }
    } ?: FrameLayout(context)

    init {
        if (controller?.showVideoContent == false)
            throw Error("This view should not have been inflated for a controller that doesn't intend to show video content")
    }

    override fun getView(): View { return view }
    override fun dispose() {
        controller?.view?.let { ghostView -> if (ghostView == view) (ghostView.parent as ViewGroup).removeView(ghostView) }
    }
}

