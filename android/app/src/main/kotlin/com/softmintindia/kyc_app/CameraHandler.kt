import android.app.Activity
import android.content.Intent
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class CameraHandler : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    companion object {
        const val REQUEST_IMAGE_CAPTURE = 1

        @JvmStatic
        fun registerWith(flutterEngine: FlutterEngine, activity: Activity) {
            val plugin = CameraHandler()
            plugin.activity = activity
            flutterEngine.plugins.add(plugin)
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "camera_handler")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "openCamera" -> openCamera()
            else -> result.notImplemented()
        }
    }

    private fun openCamera() {
        val takePictureIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        activity.startActivityForResult(takePictureIntent, REQUEST_IMAGE_CAPTURE)
    }
}
