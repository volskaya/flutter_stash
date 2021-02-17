package dev.volskaya.admob.native

import android.annotation.SuppressLint
import android.content.Context
import android.content.res.Resources
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.graphics.drawable.GradientDrawable.Orientation
import android.os.AsyncTask
import android.os.Build
import android.text.TextUtils
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import android.widget.LinearLayout.HORIZONTAL
import dev.volskaya.admob.*
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewHolder {
    var mediaView: MediaView? = null
    var iconView: ImageView? = null
    var headlineView: TextView? = null
    var advertiserView: TextView? = null
    var bodyView: TextView? = null
    var priceView: TextView? = null
    var storeView: TextView? = null
    var adAttribution: TextView? = null
    var starRatingView: RatingBar? = null
    var callToActionView: Button? = null
    var view: View? = null
}

private class InflateViewTask(
    val context: Context,
    val data: Map<*, *>,
    val onInflated: (View) -> Unit
) : AsyncTask<NativeAd, Int?, View?>() {
    @SuppressLint("InflateParams")
    override fun doInBackground(vararg params: NativeAd?): View? {
        if (params.size == 1 && params[0] != null) {
            val nativeAd = params[0]!!
            val adView = LayoutInflater.from(context).inflate(R.layout.ad_unified_native_ad, null) as NativeAdView
            val viewHolder = NativeViewHolder()
            viewHolder.view = buildView(data, context, viewHolder, nativeAd)

            adView.addView(viewHolder.view)
            define(adView, viewHolder)
            setNativeAd(adView, nativeAd)

            return adView
        }
        return null
    }

    override fun onPostExecute(result: View?) {
        result?.let { onInflated(it) }
         ?: Log.d("NativeAdPlatformView", "Couldn't inflate the native layout")
    }

    private fun define(adView: NativeAdView, viewHolder: NativeViewHolder) {
        viewHolder.mediaView?.let { it -> adView.mediaView = it } 
        viewHolder.headlineView?.let { it -> adView.headlineView = it } 
        viewHolder.bodyView?.let { it -> adView.bodyView = it } 
        viewHolder.callToActionView?.let { it -> adView.callToActionView = it } 
        viewHolder.iconView?.let { it -> adView.iconView = it } 
        viewHolder.priceView?.let { it -> adView.priceView = it } 
        viewHolder.starRatingView?.let { it -> adView.starRatingView = it } 
        viewHolder.storeView?.let { it -> adView.storeView = it } 
        viewHolder.advertiserView?.let { it -> adView.advertiserView = it } 
    }

    private fun setNativeAd(view: NativeAdView, nativeAd: NativeAd) {
        // Some assets are guaranteed to be in every NativeAd.
        view.mediaView?.setMediaContent(nativeAd.mediaContent)

        (view.headlineView as? TextView)?.text = nativeAd.headline
        (view.bodyView as? TextView)?.text = nativeAd.body
        (view.callToActionView as? Button?)?.text = nativeAd.callToAction

        // These assets aren't guaranteed to be in every NativeAd, so it's important to
        // check before trying to display them.
        val icon = nativeAd.icon

        view.iconView?.visibility = if (icon == null) View.GONE else View.VISIBLE
        (view.iconView as? ImageView)?.setImageDrawable(icon?.drawable)

        view.priceView?.visibility = if (nativeAd.price == null) View.GONE else View.VISIBLE
        (view.priceView as? TextView)?.text = nativeAd.price

        view.storeView?.visibility = if (nativeAd.store == null) View.GONE else View.VISIBLE
        (view.storeView as? TextView)?.text = nativeAd.store

        view.starRatingView?.visibility = if (nativeAd.starRating == null) View.GONE else View.VISIBLE
        if (nativeAd.starRating != null) (view.starRatingView as? RatingBar)?.rating = nativeAd.starRating!!.toFloat()

        view.advertiserView?.visibility = if (nativeAd.advertiser == null) View.GONE else View.VISIBLE
        (view.advertiserView as? TextView)?.text = nativeAd.advertiser

        // Assign native ad object to the native view.
        view.setNativeAd(nativeAd)
    }

    private fun buildView(data: Map<*, *>, context: Context, viewHolder: NativeViewHolder, nativeAd: NativeAd): View {
        val view = when (data["type"] as? String) {
            "image" -> ImageView(context).also { it.adjustViewBounds = true }
            "media" -> MediaView(context).also { it.setImageScaleType(ImageView.ScaleType.CENTER_INSIDE) }
            "ratingBar" -> RatingBar(context, null, android.R.attr.ratingBarStyleSmall)
            "linearLayout" -> LinearLayout(context).also {
                it.orientation = (data["orientation"] as? Int) ?: HORIZONTAL
                it.gravity = (data["gravity"] as? Int) ?: Gravity.TOP

                if (data["children"] != null)
                    for (child in data["children"] as List<*>)
                        it.addView(buildView(child as Map<*, *>, context, viewHolder, nativeAd))
            }
            "text" -> TextView(context).also {
                (data["style"] as? Map<*, *>)?.let { style -> it.applyText(style) }
                (data["text"] as? String)?.let { text -> it.text = text }
            }
            "button" -> Button(context).also {
                (data["style"] as? Map<*, *>)?.let { style -> it.applyText(style) }
                (data["highlightColor"] as? String)?.let { highlightColor -> it.highlightColor = Color.parseColor(highlightColor) }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) it.elevation = 2f
                (data["text"] as? String)?.let { text -> it.text = text }
            }
            else -> View(context)
        }

        (data["decoration"] as? Map<*, *>)?.let { decoration ->
            val backgroundColor = (decoration["backgroundColor"] as? String)?.let { Color.parseColor(it) }
            val shape = backgroundColor?.let { GradientDrawable(Orientation.RIGHT_LEFT, intArrayOf(it, it)) }
                    ?: GradientDrawable()

            // Radius.
            val radius = decoration["borderRadius"] as? Map<*, *>
            val topRight = ((radius?.get("topRight") as? Double) ?: 0.0).toFloat().dp()
            val topLeft = ((radius?.get("topLeft") as? Double) ?: 0.0).toFloat().dp()
            val bottomRight = ((radius?.get("bottomRight") as? Double) ?: 0.0).toFloat().dp()
            val bottomLeft = ((radius?.get("bottomLeft") as? Double) ?: 0.0).toFloat().dp()
            shape.cornerRadii = floatArrayOf(
                    topLeft, topLeft,
                    topRight, topRight,
                    bottomRight, bottomRight,
                    bottomLeft, bottomLeft)

            (data["borderWidth"] as? Double)?.let {
                val color: String = (data["borderColor"] as? String?) ?: "#FFFFFF"
                shape.setStroke(it.toInt().dp(), Color.parseColor(color))
            }

            view.background = shape
        }

        // Bounds.
        val layoutParams = view.layoutParams ?: LinearLayout.LayoutParams(-1, -1, 0f)
        val marginParams = (layoutParams as? ViewGroup.MarginLayoutParams)
                ?: ViewGroup.MarginLayoutParams(context, null)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            val margin = data["margin"] as? Map<*, *>
            (margin?.get("right") as? Double)?.let { marginParams.rightMargin = it.toInt().dp() }
            (margin?.get("left") as? Double)?.let { marginParams.leftMargin = it.toInt().dp() }
            (margin?.get("top") as? Double)?.let { marginParams.topMargin = it.toInt().dp() }
            (margin?.get("bottom") as? Double)?.let { marginParams.bottomMargin = it.toInt().dp() }
        }

        view.layoutParams = marginParams
        view.requestLayout()

        val padding = data["padding"] as? Map<*, *>
        val paddingRight = ((padding?.get("right") as? Double) ?: 0.0).toInt().dp()
        val paddingLeft = ((padding?.get("left") as? Double) ?: 0.0).toInt().dp()
        val paddingTop = ((padding?.get("top") as? Double) ?: 0.0).toInt().dp()
        val paddingBottom = ((padding?.get("bottom") as? Double) ?: 0.0).toInt().dp()

        view.setPadding(paddingLeft, paddingTop, paddingRight, paddingBottom)

        (data["height"] as? Double)?.let { marginParams.height = it.toInt().dp() }
        (data["width"] as? Double)?.let { marginParams.width = it.toInt().dp() }

        (data["id"] as? String)?.let { id ->
            view.id = "native_ad_$id".hashCode()

            when (id) {
                "advertiser" -> viewHolder.advertiserView = view as TextView
                "attribution" -> viewHolder.adAttribution = view as TextView
                "body" -> viewHolder.bodyView = view as TextView
                "button" -> viewHolder.callToActionView = view as Button
                "headline" -> viewHolder.headlineView = view as TextView
                "icon" -> viewHolder.iconView = view as ImageView
                "media" -> viewHolder.mediaView = view as MediaView
                "price" -> viewHolder.priceView = view as TextView
                "rating" -> viewHolder.starRatingView = view as RatingBar
                "store" -> viewHolder.storeView = view as TextView
            }
        }

        return view
    }
}

class NativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return NativeAdPlatformView(context, args as? Map<*, *>)
    }
}

class NativeAdPlatformView(context: Context, data: Map<*, *>?) : PlatformView {
    private val viewGroup: ViewGroup = LinearLayout(context).also { it.gravity = Gravity.CENTER_VERTICAL }
    private var controller: NativeAdmobController? = (data?.get("controllerId") as? String)?.let { NativeAdmobControllerManager.getController(it) }

    // The view can change, if the flutter widget called "updateUI".
    private var view: Map<*, *>? = (data?.get("view") as? Map<*, *>)

    init {
        // Attach to the controller.
        controller?.let { controller ->
            controller.nativeAdChanged = { it?.let { view?.let { view -> buildAsyncView(view, context, it, viewGroup)} } }
            controller.nativeAdUpdateRequested = { newView: Map<String, Any?>, ad: NativeAd? ->
                view = newView
                ad?.let { buildAsyncView(newView, context, it, viewGroup) }
            }

            // Build the first view.
            view?.let { view -> controller.nativeAd?.let { buildAsyncView(view, context, it, viewGroup) } }
        } ?: Log.e("NativeAdPlatformView", "No controller id passed to NativeAd")
    }

    override fun getView(): View { return viewGroup }
    override fun dispose() {}

    private fun buildAsyncView(data: Map<*, *>, context: Context, nativeAd: NativeAd, parent: ViewGroup?) {
        parent?.removeAllViews()
        (InflateViewTask(context, data) { parent?.addView(it) }).execute(nativeAd)
    }
}

fun Int.dp(): Int {
    // HACK: Skipping -1, -2 to avoid applying dpi to MATCH_PARENT, WRAP_CONTENT.
    return if ((this == -1 || this == -2)) this else (this * Resources.getSystem().displayMetrics.density).toInt()
}

fun Float.dp(): Float {
    return this * Resources.getSystem().displayMetrics.density
}

@SuppressLint("WrongConstant")
fun TextView.applyText(data: Map<*, *>) {
    (data["textSize"] as? Double?)?.toFloat()?.also { this.textSize = it }
    (data["textColor"] as? String)?.let { this.setTextColor(Color.parseColor(it)) }
    (data["maxLines"] as? Int?)?.let { this.maxLines = it }
    (data["minLines"] as? Int?)?.let { this.minLines = it }
    (data["typeface"] as? String)?.let { when (it) {
        "regular" -> this.setTypeface(this.typeface, Typeface.NORMAL)
        "medium" -> this.setTypeface(Typeface.SANS_SERIF, Typeface.BOLD)
        "bold" -> this.setTypeface(this.typeface, Typeface.BOLD)
    } }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        (data["letterSpacing"] as? Double)?.let { this.letterSpacing = it.toFloat().dp() / this.textSize }
    }
    this.ellipsize = TextUtils.TruncateAt.END
}
