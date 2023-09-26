package com.example.display_info

import android.content.Context
import android.util.DisplayMetrics
import android.view.WindowManager
import android.hardware.display.DisplayManager
import android.os.Build
import android.view.Display


import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class DisplayInfoPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

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
            val plugin = DisplayInfoPlugin()
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

    private fun getConnectedDisplayNames(): List<Map<String, Any>> {
        val displayList = mutableListOf<Map<String, Any>>()

        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val display = windowManager.defaultDisplay
        val metrics = DisplayMetrics()


        display.getRealMetrics(metrics)

        val xDpi = metrics.xdpi
        val yDpi = metrics.ydpi


        val widthPixels = metrics.widthPixels
        val heightPixels = metrics.heightPixels


        val displayMap = mapOf(
                    "widthPixels" to widthPixels,
                    "heightPixels" to heightPixels,
                    "xDpi" to xDpi,
                    "yDpi" to yDpi

                )

        displayList.add(displayMap)

//        val displayManager = context.getSystemService(Context.DISPLAY_SERVICE) as DisplayManager?
//        if (displayManager != null) {
//            val displays = displayManager.displays
//            for (display in displays) {
//                val displayMap = mapOf(
//                    "displayId" to display.displayId,
//                    "name" to display.name,
//                    "width" to display.width,
//                    "height" to display.height,
//                    "refreshRate" to display.refreshRate,
//                    "size" to display.getRealSize(),
//                    "isPrimary" to (display.displayId == Display.DEFAULT_DISPLAY)
//                )
//                displayList.add(displayMap)
//            }
//        }

        return displayList
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
