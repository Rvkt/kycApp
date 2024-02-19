package com.softmintindia.kyc_app

import android.os.Bundle
import android.provider.Settings.Secure
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(DeviceIdPlugin())
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val androidId = Secure.getString(contentResolver, Secure.ANDROID_ID)
        println("Android ID: $androidId")
    }
}
