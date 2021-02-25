package dev.volskaya.admob.consent

import android.app.Activity
import android.util.Log
import com.google.android.ump.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ConsentCoordinator(
        val activity: Activity,
        channel: MethodChannel,
        eventChannel: EventChannel,
        underAgeOfConsent: Boolean = false,
        forceTesting: Boolean = false,
        debugDeviceIds: List<String>?
) : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private val consentInformation: ConsentInformation = UserMessagingPlatform.getConsentInformation(activity)
    private val debugSettings: ConsentDebugSettings  = ConsentDebugSettings.Builder(activity).let { builder ->
        debugDeviceIds?.let { for (deviceId in it) builder.addTestDeviceHashedId(deviceId) }
        if (forceTesting) {
            builder.setDebugGeography(ConsentDebugSettings.DebugGeography.DEBUG_GEOGRAPHY_EEA)
            builder.setForceTesting(true)
        }
        builder.build()
    }
    private val params: ConsentRequestParameters = ConsentRequestParameters.Builder()
            .setConsentDebugSettings(debugSettings)
            .setTagForUnderAgeOfConsent(underAgeOfConsent).build()

    private var sink: EventChannel.EventSink? = null

    init {
        channel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)

        consentInformation.requestConsentInfoUpdate(
                activity,
                params,
                {
                    Log.i(null, "Consent info updated")
                    notifyConsentUpdate()
                },
                { Log.e(null, "Failed to request consent info update: ${it.errorCode} - ${it.message}") })
    }

    private fun notifyConsentUpdate() {
        sink?.success(hashMapOf<String, Any?>(
                "status" to consentInformation.consentStatus,
                "type" to consentInformation.consentType,
                "isContentFormAvailable" to consentInformation.isConsentFormAvailable
        ))
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showForm" -> {
                if (!consentInformation.isConsentFormAvailable) {
                    Log.w(null, "Tried to show consent form, but the form was not available")
                    result.success(false)
                    return
                }

                UserMessagingPlatform.loadConsentForm(
                        activity,
                        {
                            Log.i(null, "Consent form loaded: $it")

                            it.show(activity) {
                                notifyConsentUpdate()
                                result.success(true)
                            }
                        },
                        {
                            Log.e(null, "Failed to load consent form: ${it.errorCode} - ${it.message}")
                            result.error(it.errorCode.toString(), it.message, null)
                        }
                )
            }
            "reset" -> consentInformation.reset().also {
                Log.i(null, "Requested to reset consent information")
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) { sink = events }
    override fun onCancel(arguments: Any?) { sink = null }
}