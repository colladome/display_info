package com.example.display_info

import android.content.Context
import android.hardware.display.DisplayManager
import android.os.Build
import android.view.Display

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class DisplayInfo : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "display_info")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), "display_info")
            val plugin = DisplayInfo()
            plugin.context = registrar.context()
            channel.setMethodCallHandler(plugin)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "getConnectedDisplays") {
            val displays = getConnectedDisplayNames()
            result.success(displays)
        } else {
            result.notImplemented()
        }
    }

    private fun getConnectedDisplayNames(): List<String> {
        val displayNames = mutableListOf<String>()

        val displayManager = context.getSystemService(Context.DISPLAY_SERVICE) as DisplayManager?
        if (displayManager == null) {
            return displayNames
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            val displays = displayManager.getDisplays(DisplayManager.DISPLAY_CATEGORY_PRESENTATION)
            for (display in displays) {
                displayNames.add(display.name)
            }
        }

        return displayNames
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
