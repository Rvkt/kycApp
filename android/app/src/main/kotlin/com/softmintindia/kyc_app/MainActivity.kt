package com.softmintindia.kyc_app
import android.os.Bundle
import android.provider.Settings.Secure
import io.flutter.embedding.engine.FlutterEngine
import android.app.Activity
import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import android.annotation.TargetApi
import android.net.Uri
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import android.view.View
import android.widget.ArrayAdapter
import android.widget.AutoCompleteTextView
import android.widget.TextView
import android.widget.Toast
import java.util.Objects
import java.util.HashMap
import android.Manifest
import android.annotation.SuppressLint
import android.location.Location
import android.location.LocationManager
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    // CONSTANTS FIELDS INITIALIZED
    private val CHANNEL_NAME = "rd_service"
    // private val MERCHANT_USERNAME = "AEPSAGKG9YP0"
    // private val MERCHANT_PASSWORD = "JCPPM3"
    private val SUPER_MERCHANT_ID = "766"
    private val PERMISSIONS_REQUEST_LOCATION = 100
    private val MICROATM_TRANSACTION_REQUEST = 3
    private var LATITUDE = 0.000000
    private var LONGITUDE = 0.000000
    private var DEVICE_IMEI = ""

    private lateinit var methodChannel: MethodChannel
    // TO GET CURRENT DEVICE LOCATION
//    private var fusedLocationClient: FusedLocationProviderClient? = null

//    val fusedLocationClient: FusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)
    private lateinit var fusedLocationClient: FusedLocationProviderClient


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        CameraHandler.registerWith(flutterEngine, this)
        flutterEngine.plugins.add(DeviceIdPlugin())


        // INSTAINCTIATE THE METHOD CHANNLE
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)

        // SETTING UP METHOD CHANNEL CALLBACK
        methodChannel.setMethodCallHandler { call: MethodCall, _: Result ->
            if (call.method == "launchExternalApp") {
                val url: String? = call.argument("package")
                val pidOptXML: String? = call.argument("pidXml")
                launchExternalApp(url, pidOptXML)
            } else if (call.method == "launchF2aCapture") {
                val url: String? = call.argument("package")
                val pidOptXML: String? = call.argument("pidXml")
                launchF2aCapture(url, pidOptXML)
            } else if (call.method == "checkBiometricStatus"){
                val pkg: String? = call.argument("package")
                val readyState = pkg?.let {isRDServiceReady(this@MainActivity, it)}
                val data: MutableMap<String, Any> = HashMap()
                data["packageName"] = pkg?: ""
                data["status"] = readyState?: false
                Log.i("METHOD_CALL", "checkBiometricStatus CALLING......")
                methodChannel.invokeMethod("checkBiometricStatus", data)

            }else if(call.method == "MICRO_ATM_TRANSACTION_REQUEST") {
                val mobile: String? = call.argument("mobile")
//                val amount: Double? = Objects.requireNonNull(call.argument("amount")).toString().toDouble()
//                val amount: Double? = call.argument("amount")?.toString()?.toDouble()
                val amount: Int? = call.argument<Int>("amount")
                android.util.Log.i("TRANSACTION_AMOUNT", ""+amount);
                val mUsername: String? = call.argument("muser")
                val mPassword: String? = call.argument("mpass")
                val type: String? = call.argument("type")
                val orderId: String? = call.argument("orderId")
                android.util.Log.i("REQUESTED_MOBILE", mobile!!)
//                doMicroAtmTransaction(mobile, amount, mUsername, mPassword, type, orderId)
            }
        }

    }

    private fun launchExternalApp(url: String?, pidOptXML: String?) {
        val intent1 = Intent("in.gov.uidai.rdservice.fp.CAPTURE")
        intent1.`package` = url
        intent1.putExtra("PID_OPTIONS", pidOptXML)
        startActivityForResult(intent1, 1)
        Log.i("METHOD_CALL", "launchExternalApp CALLING......")
    }

    private fun launchF2aCapture(url: String?, pidOptXML: String?) {
        val intent1 = Intent("in.gov.uidai.rdservice.fp.CAPTURE")
        intent1.`package` = url
        intent1.putExtra("PID_OPTIONS", pidOptXML)
        startActivityForResult(intent1, 2)
        Log.i("METHOD_CALL", "launchF2aCapture CALLING......")
    }

    companion object {
        private fun isRDServiceInstalled(context: Context, packageId: String): Boolean {
            val pm = context.packageManager
            return try {
                pm.getPackageInfo(packageId, PackageManager.GET_ACTIVITIES)
                true
            } catch (e: PackageManager.NameNotFoundException) {
                false
            }
        }
    }

    private fun requestLocation() {
        // CHECKING THE LOCATION PERMISSION IS ENABLED OR NOT
        if (ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.ACCESS_FINE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.ACCESS_COARSE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED
        ) {
            // REQUESING FOR LOCATION PERMISSION
            ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                    PERMISSIONS_REQUEST_LOCATION
            )
            return
        }
        fusedLocationClient!!.lastLocation
                .addOnSuccessListener(this) { location: Location? ->
                    if (location != null) {
                        val latitude = location.latitude
                        val longitude = location.longitude
                        LATITUDE = latitude
                        LONGITUDE = longitude
                        Log.i("LATLONG", "CURRENT LATITUDE : " + LATITUDE + " LONGITUDE : " + LONGITUDE)
                    }
                }
                .addOnFailureListener(this) { e: Exception ->
                    Toast.makeText(
                            this@MainActivity,
                            "Failed to get location: " + e.message,
                            Toast.LENGTH_SHORT
                    ).show()
                }
    }

    override fun onRequestPermissionsResult(
            requestCode: Int,
            permissions: Array<String>,
            grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSIONS_REQUEST_LOCATION) {
            if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                requestLocation()
            } else {
                Toast.makeText(
                        this,
                        "Location permission denied",
                        Toast.LENGTH_SHORT
                ).show()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        val locationManager = getSystemService(LOCATION_SERVICE) as LocationManager
        if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // INSTAINCTIATE THE FusedLocationProviderClient
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        // GETTIGN THE INSTANCE OF LOCATION SERVICE
        val locationManager = getSystemService(LOCATION_SERVICE) as LocationManager
        // CHECKING THE GPS IS ENABLE OR NOT
        if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            // MAKING INTENT TO START GPS SERVICE
            val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            // SENDING BROADCAST TO START GPS
            startActivity(intent)
        }
        // GETTING ANDROID DEVICE ID
        @SuppressLint("HardwareIds") val androidId = Settings.Secure.getString(
                contentResolver, Settings.Secure.ANDROID_ID
        )

        if (androidId != null) {
            DEVICE_IMEI = androidId
//            Toast.makeText(this, "Android ID: $androidId", Toast.LENGTH_SHORT).show()
        }
        // CHECKING THE LOCATION PERMISSION
        if (ContextCompat.checkSelfPermission(
                        this, Manifest.permission.ACCESS_FINE_LOCATION
                )
                != PackageManager.PERMISSION_GRANTED
        ) {
            // SENDING THE REQUEST OF LOCATION PERMISSION
            ActivityCompat.requestPermissions(
                    this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                    PERMISSIONS_REQUEST_LOCATION
            )
        } else {
            // OTHERWISE DIRECTLY REQUESTING FOR THE LOCATION LATITUDE & LONGITUDE
            requestLocation()
        }
    }

    fun isRDServiceReady(context: Context, packageId: String): Boolean {
        return if (isRDServiceInstalled(context, packageId)) {
            val intent = Intent("in.gov.uidai.rdservice.fp.INFO")
            val packageManager = context.packageManager
            val activityList =
                    packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)
            val isSafe = activityList.size > 0
            if (!isSafe) {
                Toast.makeText(context, "MAY RD SERVICE NOT INSTALLED PROPERLY", Toast.LENGTH_SHORT)
                        .show()
            }
            isSafe
        } else {
            Toast.makeText(context, "APP IS NOT INSTALLED!!", Toast.LENGTH_SHORT).show()
            false
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        Log.i("METHOD_CALL", "onActivityResult CALLING......")
        Log.i("RESULT_CODE", requestCode.toString())
        if (resultCode == RESULT_OK) {
            val b = data?.extras
            if (requestCode == 1) {
                b?.getString("PID_DATA")?.let { Log.i("BIO_DATA", it) }
                methodChannel.invokeMethod(
                        "getBiometricCallback",
                        b?.getString("PID_DATA")
                )
            } else if (requestCode == 2) {
                b?.getString("PID_DATA")?.let { Log.i("BIO_DATA", it) }
                methodChannel.invokeMethod(
                        "f2aBiometric",
                        b?.getString("PID_DATA")
                )
            }
        }
    }
}
