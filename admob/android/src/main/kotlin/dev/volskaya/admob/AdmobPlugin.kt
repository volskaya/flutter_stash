package dev.volskaya.admob

import android.app.Activity
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import dev.volskaya.admob.app_open.AppOpenAdControllerManager
import dev.volskaya.admob.banner.*
import dev.volskaya.admob.interstitial.InterstitialAdControllerManager
import com.google.android.gms.ads.MobileAds
import com.google.android.gms.ads.RequestConfiguration

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import dev.volskaya.admob.native.*
import dev.volskaya.admob.rewarded.RewardedAdControllerManager
import com.google.android.gms.ads.AdError
import com.google.android.gms.ads.AdRequest
import com.google.android.ump.ConsentForm
import com.google.android.ump.ConsentInformation
import dev.volskaya.admob.consent.ConsentCoordinator
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel

class AdmobPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var messenger: BinaryMessenger
    private lateinit var consentCoordinatorChannel: MethodChannel
    private lateinit var consentCoordinatorEventChannel: EventChannel

    private var consentCoordinator: ConsentCoordinator? = null
    private val nativeAdLoaders: HashMap<String, NativeAdLoader> = hashMapOf()

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "admob").also { it.setMethodCallHandler(this) }
        messenger = binding.binaryMessenger
        consentCoordinatorChannel = MethodChannel(messenger, "consentCoordinator")
        consentCoordinatorEventChannel = EventChannel(messenger, "consentCoordinator.state")

        binding.platformViewRegistry.registerViewFactory("banner_admob", BannerAdViewFactory())
        binding.platformViewRegistry.registerViewFactory("nativeAdVideoMedia", NativeAdMediaViewFactory())
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initialize" -> {
                MobileAds.initialize(activity) {
                    val debugDeviceIds = call.argument<List<String>>("debugDeviceIds")
                    debugDeviceIds?.let {
                        if (debugDeviceIds.isNotEmpty()) {
                            val configuration = MobileAds
                                    .getRequestConfiguration()
                                    .toBuilder()
                                    .setTestDeviceIds(it)
                                    .build()
                            MobileAds.setRequestConfiguration(configuration)
                        }
                    }

                    // Construct the consent coordinator
                    consentCoordinator = ConsentCoordinator(
                            activity,
                            consentCoordinatorChannel,
                            consentCoordinatorEventChannel,
                            call.argument<Boolean>("underAgeOfConsent")!!,
                            call.argument<Boolean>("forceTesting")!!,
                            debugDeviceIds
                    )

                    // Construct the native ad loaders.
                    call.argument<Map<*, *>>("props")?.let {
                        val nativeAd = it["nativeAd"] as Map<*, *>
                        val unitId = nativeAd["unitId"] as String

                        for (entry in nativeAd["options"] as Map<*, *>) {
                            val key = entry.key as String
                            val options = entry.value as Map<*, *>

                            nativeAdLoaders[key] = NativeAdLoader(activity.applicationContext, unitId, options)
                        }
                    }

                    result.success(Build.VERSION.SDK_INT)
                }
            }
            "nativeAdControllerCreate" -> {
                val id = call.argument<String>("id")!!
                val options = call.argument<String>("options")!!
                NativeAdmobController.create(id, messenger, activity, nativeAdLoaders[options]!!)
                result.success(null)
            }
            // Banner Ads Controller.
            "initBannerAdController" -> {
                BannerAdControllerManager.createController( call.argument<String>("id")!!, messenger, activity)
                result.success(null)
            }
            "disposeBannerAdController" -> {
                BannerAdControllerManager.removeController(call.argument<String>("id")!!)
                result.success(null)
            }
            // Interstitial.
            "initInterstitialAd" -> {
                InterstitialAdControllerManager.createController(
                        call.argument<String>("id")!!,
                        messenger,
                        activity)
                result.success(null)
            }
            "disposeInterstitialAd" -> {
                InterstitialAdControllerManager.removeController(call.argument<String>("id")!!)
                result.success(null)
            }
            // Rewarded.
            "initRewardedAd" -> {
                RewardedAdControllerManager.createController(
                        call.argument<String>("id")!!,
                        messenger,
                        activity)
                result.success(null)
            }
            "disposeRewardedAd" -> {
                RewardedAdControllerManager.removeController(call.argument<String>("id")!!)
                result.success(null)
            }
            // App Open.
            "initAppOpenAd" -> {
                AppOpenAdControllerManager.createController(
                        call.argument<String>("id")!!,
                        messenger,
                        activity
                )
            }
            "disposeAppOpenAd" -> {
                AppOpenAdControllerManager.removeController(call.argument<String>("id")!!)
            }
            // General Controller.
            "isTestDevice" -> result.success(AdRequest.Builder().build().isTestDevice(activity))
            "setChildDirected" -> {
                val child: Int = when (call.argument<Boolean>("directed")) {
                    true -> RequestConfiguration.TAG_FOR_CHILD_DIRECTED_TREATMENT_TRUE
                    false -> RequestConfiguration.TAG_FOR_CHILD_DIRECTED_TREATMENT_FALSE
                    null -> RequestConfiguration.TAG_FOR_CHILD_DIRECTED_TREATMENT_UNSPECIFIED
                }
                val configuration = MobileAds
                        .getRequestConfiguration()
                        .toBuilder()
                        .setTagForChildDirectedTreatment(child)
                        .build()
                MobileAds.setRequestConfiguration(configuration)
                result.success(null)
            }
            "setTagForUnderAgeOfConsent" -> {
                val age: Int = when (call.argument<Boolean>("under")) {
                    true -> RequestConfiguration.TAG_FOR_UNDER_AGE_OF_CONSENT_TRUE
                    false -> RequestConfiguration.TAG_FOR_UNDER_AGE_OF_CONSENT_FALSE
                    null -> RequestConfiguration.TAG_FOR_UNDER_AGE_OF_CONSENT_UNSPECIFIED
                }
                val configuration = MobileAds
                        .getRequestConfiguration()
                        .toBuilder()
                        .setTagForUnderAgeOfConsent(age)
                        .build()
                MobileAds.setRequestConfiguration(configuration)
                result.success(null)
            }
            "setMaxAdContentRating" -> {
                val age: String = when (call.argument<Int>("maxRating")) {
                    0 -> RequestConfiguration.MAX_AD_CONTENT_RATING_G
                    1 -> RequestConfiguration.MAX_AD_CONTENT_RATING_PG
                    2 -> RequestConfiguration.MAX_AD_CONTENT_RATING_T
                    3 -> RequestConfiguration.MAX_AD_CONTENT_RATING_MA
                    else -> RequestConfiguration.MAX_AD_CONTENT_RATING_G
                }
                val configuration = MobileAds
                        .getRequestConfiguration()
                        .toBuilder()
                        .setMaxAdContentRating(age)
                        .build()
                MobileAds.setRequestConfiguration(configuration)
                result.success(null)
            }
            "setAppVolume" -> {
                val volume: Float = call.argument<Double>("volume")!!.toFloat()
                MobileAds.setAppVolume(volume)
                result.success(null)
            }
            "setAppMuted" -> {
                val muted: Boolean = call.argument<Boolean>("muted")!!
                MobileAds.setAppMuted(muted)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {}
}

fun encodeError(error: AdError?): Map<String, Any?> {
    return mapOf(
            "errorCode" to error?.code,
            "domain" to error?.domain,
            "message" to error?.message,
            "cause" to encodeError(error?.cause)
    )
}
