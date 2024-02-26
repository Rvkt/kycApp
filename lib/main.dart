import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/bank_kyc_otp_verification.dart';
import 'package:kyc_app/bank_kyc_screen.dart';
import 'package:kyc_app/core/auth_screen.dart';
import 'package:kyc_app/dashboard_screen.dart';
import 'package:kyc_app/fo_verification_screen.dart';
import 'package:kyc_app/core/login/login_screen.dart';
import 'package:kyc_app/merchant_finger_capture_screen.dart';
import 'package:kyc_app/merchants_documents_upload_screen.dart';
import 'package:kyc_app/otp_verification_screen.dart';
import 'package:kyc_app/providers/image_provider.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/providers/user_provider.dart';
import 'package:kyc_app/thank_you_screen.dart';
import 'package:kyc_app/shop_verification_screen_via_image.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_screen.dart';
import 'providers/auth_provider.dart';
import 'show_uploaded_screen.dart';
import 'success_screen.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
    //   const CameraExampleHome(),
  );
  getDeviceId();
}

// Future<String?> getDeviceId() async {
//   if (Platform.isAndroid) {
//     try {
//       MethodChannel methodChannel = const MethodChannel('device_id');
//       dynamic result = await methodChannel.invokeMethod('getAndroidId');
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (result != null && result is String) {
//         prefs.setString('deviceId', result);
//         Logger().i('Device ID: $result');
//         return result;
//       } else {
//         return 'Failed to get Android ID.';
//       }
//     } on PlatformException {
//       return 'Failed to get Android ID.';
//     }
//   } else if (Platform.isIOS) {
//     // For iOS, you can use the 'identifierForVendor'
//     return Platform.environment['IOS_ID'];
//   } else {
//     // For other platforms, return a default value
//     return 'Unknown';
//   }
// }

Future<String?> getDeviceId() async {
  if (Platform.isAndroid) {
    try {
      MethodChannel methodChannel = const MethodChannel('device_id');
      dynamic result = await methodChannel.invokeMethod('getAndroidId');
      if (result != null && result is String) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('deviceId', result);
        Logger().i('Device ID: $result');
        return result;
      } else {
        return 'Failed to get Android ID.';
      }
    } on PlatformException {
      return 'Failed to get Android ID.';
    }
  }
  return null;
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankKycProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomImageProvider(),
        ),
      ],
      child: const MaterialApp(
        // debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // home: PageView(
        //   children: const [
            // LoginScreen(),
            // OtpVerificationScreen(),
            // DashboardScreen(),
            // BankKycScreen(),
            // OtpVerificationScreen(),
            // MerchantFingerCaptureScreen(),
            // SuccessScreen(),
            // KycDocumentsUploadScreen(),
            // ShowUploadedImageScreen(),
            // MerchantDocumentsUploadScreen(),
            // OtpVerificationScreen(),
            // FoVerificationScreen(),
            // ThankYouScreen(),
          // ],
        // ),
        // navigatorKey: navigatorKey,
        home: AuthScreen(),
        // home: ShopVerificationScreen(),
        // home: MerchantFingerCaptureScreen(mobile: '9988776655', agentId: 'qwerty', kycToken: '', wadh: '',)
      ),
    );
  }
}

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final cameras = await availableCameras();
//   runApp(CameraApp(cameras: cameras));
// }
//
// /// CameraApp is the Main Application.
// class CameraApp extends StatefulWidget {
//   final List<CameraDescription> cameras;
//
//   /// Default Constructor
//   const CameraApp({Key? key, required this.cameras}) : super(key: key);
//
//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }
//
// class _CameraAppState extends State<CameraApp> {
//   late CameraController? controller;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.cameras.isNotEmpty) {
//       controller = CameraController(widget.cameras[0], ResolutionPreset.max);
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       }).catchError((Object e) {
//         if (e is CameraException) {
//           switch (e.code) {
//             case 'CameraAccessDenied':
//             // Handle access errors here.
//               break;
//             default:
//             // Handle other errors here.
//               break;
//           }
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.cameras.isEmpty) {
//       return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('No Camera Available'),
//           ),
//           body: const Center(
//             child: Text('No camera found on this device.'),
//           ),
//         ),
//       );
//     }
//
//     if (controller == null || !controller!.value.isInitialized) {
//       return Container();
//     }
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Camera App'),
//         ),
//         body: CameraPreview(controller!),
//       ),
//     );
//   }
// }

