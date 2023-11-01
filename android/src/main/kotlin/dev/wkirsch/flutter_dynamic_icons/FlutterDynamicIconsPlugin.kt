package dev.wkirsch.flutter_dynamic_icons

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build.*

import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.startActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import java.lang.StringBuilder
import java.lang.ref.WeakReference


/** FlutterDynamicIconsPlugin */
class FlutterDynamicIconsPlugin: ContextAwarePlugin() {
  override val pluginName: String = "flutter_dynamic_icons"

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "setIcon") {
            try {
                val icon = call.argument<String>("icon")
                val listIcon = call.argument<List<String>>("listAvailableIcon")
                if (listIcon != null && icon != null) {
                    setIcon(icon, listIcon)
                }
                result.success(true)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        } 
    else if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }


    private fun setIcon(targetIcon: String, activitiesArray: List<String>) {
        val packageManager: PackageManager = applicationContext!!.packageManager
        val packageName = applicationContext!!.packageName
        val parts = packageName.split(".")
        val firstPart = parts[0]
        val secondPart = parts[1]
        val thirdPart = parts[2]
        val libraryName = "$firstPart.$secondPart.$thirdPart"
        val className = StringBuilder()
        className.append(packageName)
        className.append(".")
        className.append(targetIcon)

        for (value in activitiesArray) {
            val action = if (value == targetIcon) {
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED
            } else {
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            }
            packageManager.setComponentEnabledSetting(
                ComponentName(packageName!!, "$libraryName.$value"),
                action, PackageManager.DONT_KILL_APP
            )
        }
    }
}

abstract class ContextAwarePlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    abstract val pluginName: String

    protected val activity get() = activityReference.get()
    protected val applicationContext get() =
        contextReference.get() ?: activity?.applicationContext

    private var activityReference = WeakReference<Activity>(null)
    private var contextReference = WeakReference<Context>(null)

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityReference.clear()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        activityReference.clear()
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, pluginName)
        channel.setMethodCallHandler(this)

        contextReference = WeakReference(flutterPluginBinding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

