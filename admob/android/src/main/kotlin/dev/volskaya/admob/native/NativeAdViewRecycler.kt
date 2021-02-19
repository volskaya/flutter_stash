package dev.volskaya.admob.native

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.AsyncTask
import android.os.Build
import android.os.Looper
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.volskaya.admob.R
import java.lang.annotation.Native

private class InflateAdTask(
        val parent: ViewGroup,
        val view: NativeAdView,
        val callback: ((NativeAdView) -> Unit)?
) : AsyncTask<NativeAd, Int?, NativeAdView?>() {
    override fun doInBackground(vararg params: NativeAd?): NativeAdView? {
        if (params.isNotEmpty() && params[0] != null) {
            val nativeAd = params[0]!!
            val isOnUiThread = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                Looper.getMainLooper().isCurrentThread else false
            Log.d("RecyclableAdView", "Mounted an ad on $parent ($this), is on UI: $isOnUiThread")
            setNativeAd(view, nativeAd)
            return view
        }

        return null
    }

    override fun onPostExecute(result: NativeAdView?) {
        super.onPostExecute(result)

        result?.let { callback?.let { callback -> callback(it) } }
    }

    private fun setNativeAd(view: NativeAdView, nativeAd: NativeAd) {
        // Guaranteed assets.
        val point1 = System.currentTimeMillis()
        view.mediaView?.setMediaContent(nativeAd.mediaContent)

        (view.headlineView as? TextView)?.text = nativeAd.headline
        (view.bodyView as? TextView)?.text = nativeAd.body
        (view.callToActionView as? Button?)?.text = nativeAd.callToAction
        Log.d("RecyclableAdView", "Views assigned in ${System.currentTimeMillis() - point1} ms")

        // Assign native ad object to the native view.
        val point2 = System.currentTimeMillis()
        view.setNativeAd(nativeAd)
        Log.d("RecyclableAdView", "setNativeAd called in ${System.currentTimeMillis() - point2} ms")
    }
}

class RecyclableAdView(val view: NativeAdView, val activity: Activity)  {
    private var parent: ViewGroup? = null
    var mounted: Boolean = false

    fun mount(parent: ViewGroup, nativeAd: NativeAd) { mount(parent, nativeAd, null) }
    fun mount(parent: ViewGroup, nativeAd: NativeAd, callback: ((NativeAdView) -> Unit)?) {
        if (mounted) throw Error("This recyclable ad view is already mounted")
        this.parent = parent
        this.mounted = true

        val isOnUiThread = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            Looper.getMainLooper().isCurrentThread else false
        Log.d("RecyclableAdView", "RecyclableAdView is on the UI thread: $isOnUiThread")

        (InflateAdTask(parent, view) {
            // This was run in a background thread, check if the view is still needed.
            // FIXME: Check the ID of the ad or something too.
            if (!mounted) return@InflateAdTask

            val point = System.currentTimeMillis()
            callback?.let { it(view) } ?: parent.addView(view)
            Log.d("RecyclableAdView", "Native ad added to the parent view in ${System.currentTimeMillis() - point} ms")
        }).execute(nativeAd)

//        activity.runOnUiThread {
//            val isOnUiThread = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
//                Looper.getMainLooper().isCurrentThread else false
//            Log.d("RecyclableAdView", "Mounted an ad on $parent ($this), is on UI: $isOnUiThread")
//            setNativeAd(view, nativeAd)
//            callback?.let { it(view) } ?: parent.addView(view)
//        }
    }

    fun unmount() {
        if (!mounted) throw Error("Recyclable is not mounted")
        mounted = false

        Log.d("RecyclableAdView", "Removed an ad from $parent ($this)")
        val time = System.currentTimeMillis()
        val parent = this.parent!!
        activity.runOnUiThread { parent.removeView(view) }
        this.parent = null
        Log.d("RecyclableAdView", "Native ad removed from the parent view in ${System.currentTimeMillis() - time} ms")
    }

    private fun setNativeAd(view: NativeAdView, nativeAd: NativeAd) {
        // Guaranteed assets.
        val point1 = System.currentTimeMillis()
        view.mediaView?.setMediaContent(nativeAd.mediaContent)

        (view.headlineView as? TextView)?.text = nativeAd.headline
        (view.bodyView as? TextView)?.text = nativeAd.body
        (view.callToActionView as? Button?)?.text = nativeAd.callToAction
        Log.d("RecyclableAdView", "Views assigned in ${System.currentTimeMillis() - point1} ms")

        // Optional assets.
//        view.iconView?.visibility = if (nativeAd.icon == null) View.GONE else View.VISIBLE
//        (view.iconView as? ImageView)?.setImageDrawable(nativeAd.icon?.drawable)
//
//        view.priceView?.visibility = if (nativeAd.price == null) View.GONE else View.VISIBLE
//        (view.priceView as? TextView)?.text = nativeAd.price
//
//        view.storeView?.visibility = if (nativeAd.store == null) View.GONE else View.VISIBLE
//        (view.storeView as? TextView)?.text = nativeAd.store
//
//        view.starRatingView?.visibility = if (nativeAd.starRating == null) View.GONE else View.VISIBLE
//        if (nativeAd.starRating != null) (view.starRatingView as? RatingBar)?.rating = nativeAd.starRating!!.toFloat()
//
//        view.advertiserView?.visibility = if (nativeAd.advertiser == null) View.GONE else View.VISIBLE
//        (view.advertiserView as? TextView)?.text = nativeAd.advertiser

        // Assign native ad object to the native view.
        val point2 = System.currentTimeMillis()
        view.setNativeAd(nativeAd)
        Log.d("RecyclableAdView", "setNativeAd called in ${System.currentTimeMillis() - point2} ms")
    }
}

object NativeAdViewRecycler {
    private val cache: HashMap<String, Array<RecyclableAdView>?> = hashMapOf()

    // Mount and return a RecyclableAdView.
    fun mount(id: String, parent: ViewGroup, nativeAd: NativeAd): RecyclableAdView? { return mount(id, parent, nativeAd, null) }
    fun mount(id: String, parent: ViewGroup, nativeAd: NativeAd, callback: ((NativeAdView) -> Unit)?): RecyclableAdView? {
        if (!cache.containsKey(id)) throw Error("$id views were never inflated")

        cache[id]?.let {
            for (recyclableView in it) {
                if (!recyclableView.mounted) {
                    recyclableView.mount(parent, nativeAd, callback)
                    return recyclableView
                }
            }
        }

        return null
    }

    // Inflates and caches an ad layout passed from Flutter. This layout must not change
    // throughout the lifecycle of the app.
    fun inflateViews(activity: Activity, id: String, count: Int = 20, layout: Map<*, *>) {
        return // Disabled

        if (count <= 0) throw Error("Inflating views with a wrong `count` - $count")

        // Inflate a precached amount of views.
        val inflater = LayoutInflater.from(activity.applicationContext)
        val views = Array(count) {
//            val nativeAdView = inflater.inflate(R.layout.ad_unified_native_ad, null) as NativeAdView
//            val view = buildView(layout, context, nativeAdView)

//            nativeAdView.addView(view)
//            RecyclableAdView(nativeAdView)

            val view = inflater.inflate(R.layout.background_native_ad, null) as NativeAdView
            view.headlineView = view.findViewById<TextView>(R.id.background_native_ad_view_headline)
            view.bodyView = view.findViewById<TextView>(R.id.background_native_ad_view_body)
            view.callToActionView = view.findViewById<Button>(R.id.background_native_ad_view_button)

            RecyclableAdView(view, activity)
        }

        cache[id] = views // Cache the build views.
    }

//    private fun buildView(data: Map<*, *>, context: Context, nativeAdView: NativeAdView): View {
//        val view = when (data["type"] as? String) {
//            "image" -> ImageView(context).also { it.adjustViewBounds = true }
//            "media" -> MediaView(context).also {
//                it.setImageScaleType(ImageView.ScaleType.CENTER_INSIDE)
//                it.setOnHierarchyChangeListener(object : ViewGroup.OnHierarchyChangeListener {
//                    override fun onChildViewAdded(parent: View, child: View) {
//                        if (child is ImageView) child.adjustViewBounds = true
//                        // TODO: Make sure video also resizes.
//                    }
//
//                    override fun onChildViewRemoved(parent: View, child: View) {}
//                })
//            }
//            "ratingBar" -> RatingBar(context, null, android.R.attr.ratingBarStyleSmall)
//            "linearLayout" -> LinearLayout(context).also {
//                it.orientation = (data["orientation"] as? Int) ?: LinearLayout.HORIZONTAL
//                it.gravity = (data["gravity"] as? Int) ?: Gravity.TOP
//
//                (data["children"] as? List<*>)?.let { children ->
//                    for (child in children) it.addView(buildView(child as Map<*, *>, context, nativeAdView))
//                }
//            }
//            "text" -> TextView(context).also {
//                (data["style"] as? Map<*, *>)?.let { style -> it.applyText(style) }
//                (data["text"] as? String)?.let { text -> it.text = text }
//            }
//            "button" -> Button(context).also {
//                (data["style"] as? Map<*, *>)?.let { style -> it.applyText(style) }
//                (data["highlightColor"] as? String)?.let { highlightColor -> it.highlightColor = Color.parseColor(highlightColor) }
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) it.elevation = 2f
//                (data["text"] as? String)?.let { text -> it.text = text }
//            }
//            else -> View(context)
//        }
//
//        (data["decoration"] as? Map<*, *>)?.let { decoration ->
//            val backgroundColor = (decoration["backgroundColor"] as? String)?.let { Color.parseColor(it) }
//            val shape = backgroundColor?.let { GradientDrawable(GradientDrawable.Orientation.RIGHT_LEFT, intArrayOf(it, it)) }
//                    ?: GradientDrawable()
//
//            // Radius.
//            val radius = decoration["borderRadius"] as? Map<*, *>
//            val topRight = ((radius?.get("topRight") as? Double) ?: 0.0).toFloat().dp()
//            val topLeft = ((radius?.get("topLeft") as? Double) ?: 0.0).toFloat().dp()
//            val bottomRight = ((radius?.get("bottomRight") as? Double) ?: 0.0).toFloat().dp()
//            val bottomLeft = ((radius?.get("bottomLeft") as? Double) ?: 0.0).toFloat().dp()
//            shape.cornerRadii = floatArrayOf(
//                    topLeft, topLeft,
//                    topRight, topRight,
//                    bottomRight, bottomRight,
//                    bottomLeft, bottomLeft)
//
//            (data["borderWidth"] as? Double)?.let {
//                val color: String = (data["borderColor"] as? String?) ?: "#FFFFFF"
//                shape.setStroke(it.toInt().dp(), Color.parseColor(color))
//            }
//
//            view.background = shape
//        }
//
//        // Bounds.
//        val layoutParams = view.layoutParams ?: LinearLayout.LayoutParams(-1, -1, 0f)
//        val marginParams = (layoutParams as? ViewGroup.MarginLayoutParams)
//                ?: ViewGroup.MarginLayoutParams(context, null)
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
//            val margin = data["margin"] as? Map<*, *>
//            (margin?.get("right") as? Double)?.let { marginParams.rightMargin = it.toInt().dp() }
//            (margin?.get("left") as? Double)?.let { marginParams.leftMargin = it.toInt().dp() }
//            (margin?.get("top") as? Double)?.let { marginParams.topMargin = it.toInt().dp() }
//            (margin?.get("bottom") as? Double)?.let { marginParams.bottomMargin = it.toInt().dp() }
//        }
//
//        view.layoutParams = marginParams
//        view.requestLayout()
//
//        val padding = data["padding"] as? Map<*, *>
//        val paddingRight = ((padding?.get("right") as? Double) ?: 0.0).toInt().dp()
//        val paddingLeft = ((padding?.get("left") as? Double) ?: 0.0).toInt().dp()
//        val paddingTop = ((padding?.get("top") as? Double) ?: 0.0).toInt().dp()
//        val paddingBottom = ((padding?.get("bottom") as? Double) ?: 0.0).toInt().dp()
//
//        view.setPadding(paddingLeft, paddingTop, paddingRight, paddingBottom)
//
//        (data["height"] as? Double)?.let { marginParams.height = it.toInt().dp() }
//        (data["width"] as? Double)?.let { marginParams.width = it.toInt().dp() }
//
//        (data["id"] as? String)?.let { id ->
////            view.id = "native_ad_$id".hashCode()
//
//            when (id) {
//                "advertiser" -> nativeAdView.advertiserView = view as TextView
////                "attribution" -> nativeAdView.attributionView = view as TextView
//                "body" -> nativeAdView.bodyView = view as TextView
//                "button" -> nativeAdView.callToActionView = view as Button
//                "headline" -> nativeAdView.headlineView = view as TextView
//                "icon" -> nativeAdView.iconView = view as ImageView
//                "media" -> nativeAdView.mediaView = view as MediaView
//                "price" -> nativeAdView.priceView = view as TextView
//                "rating" -> nativeAdView.starRatingView = view as RatingBar
//                "store" -> nativeAdView.storeView = view as TextView
//            }
//        }
//
//        return view
//    }
}