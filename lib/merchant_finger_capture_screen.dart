import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/utils/validators.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:kyc_app/widgets/custom_dropdown_search_field_widget.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:xml/xml.dart';
import 'package:provider/provider.dart';

const platform = MethodChannel('rd_service');

class MerchantFingerCaptureScreen extends StatefulWidget {
  final String mobile;
  final String agentId;
  final String wadh;

  // final String aadhar;
  final String kycToken;

  const MerchantFingerCaptureScreen({super.key, required this.mobile, required this.agentId, required this.kycToken, required this.wadh});

  @override
  State<MerchantFingerCaptureScreen> createState() => _MerchantFingerCaptureScreenState();
}

class _MerchantFingerCaptureScreenState extends State<MerchantFingerCaptureScreen> {
  String biometricData = '';

  // String wadh = '';
  String selectedDevice = '';

  // moveToUpload(BuildContext context, String mobile, String agentId, String aadhar, String biometricData, String kycToken, String wadh) async {
  //   final bankKycProvider = Provider.of<BankKycProvider>(context, listen: false);
  //   await bankKycProvider.yesBiometricKyc(context, mobile, agentId, aadhar, biometricData, kycToken, wadh);
  //   Logger().i(bankKycProvider.yesBiometricKycResponseModel);
  // }

  final List<Map<String, dynamic>> devicesMap = [
    {'value': 'com.acpl.registersdk', 'label': 'Startek'},
    {'value': 'com.scl.rdservice', 'label': 'Morpho'},
    {'value': 'com.nextbiometrics.onetouchrdservic', 'label': 'NEXT Biometrics OneTouch L0'},
    {'value': 'com.mantra.rdservice', 'label': 'Mantra'},
    {'value': 'com.precision.pb510.rdservice', 'label': 'Precision'},
  ];
  TextEditingController aadharController = TextEditingController();

  final pidOptions = '<PidOptions ver="1.0"> <Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="20000" posh="UNKNOWN" env="P" wadh=""/> <CustOpts><Param name="mantrakey" value="" /></CustOpts> </PidOptions>';

  void setupMethodChannel() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'getBiometricCallback') {
        String data = call.arguments as String;

        final document = XmlDocument.parse(data);
        final errInfo = document.findElements('PidData').first.findElements('Resp').first.getAttribute('errInfo');

        final errCode = document.findElements('PidData').first.findElements('Resp').first.getAttribute('errCode');

        Logger().w('${errCode!}: ${errInfo!}');

        if (errCode == "0") {
          setState(() {
            biometricData = data;
            // canProceed = true;
          });
        }
        Logger().w(biometricData);

        // else {
        //   showCustomDialog(
        //     // context: context,
        //     message: "$errCode - $errInfo",
        //   );
        // }

        // Execute the method in main.dart when called from native code
      } else if (call.method == "checkBiometricStatus") {
        Map<dynamic, dynamic> data = call.arguments as Map<dynamic, dynamic>;

        bool isReady = data['status'];
        String packageName = data['packageName'];

        if (isReady) {
          await platform.invokeMethod('launchExternalApp', {
            'package': packageName,
            "pidXml": pidOptions,
          });
        } else {
          Logger().e('Device is not ready...');
          // showCustomDialog(
          //   // context: context,
          //   message: 'Device is not ready...',
          // );
        }
      }
    });
  }

  void captureBiometric(packageName) async {
    String pidOptions =
        '<PidOptions ver="1.0"> <Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="20000" posh="UNKNOWN" env="P" wadh=""/> <CustOpts><Param name="mantrakey" value="" /></CustOpts> </PidOptions>';

    // await platform.invokeMethod('checkBiometricStatus', {
    //   'package': getPackageForDevice(deviceName),
    // });

    await platform.invokeMethod('launchExternalApp', {
      'package': packageName,
      "pidXml": pidOptions,
    });
  }

  @override
  Widget build(BuildContext context) {
    setupMethodChannel();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            // alignment: const Alignment(0, 0),
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Image.asset(
              'assets/logo/logo.png',
              width: screenWidth * 0.6,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Merchant Finger Capture',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          CustomTextFormField(
            labelText: 'Enter Aadhar Number',
            keyboardType: TextInputType.number,
            controller: aadharController,
            validator: (value) {
              validateAadharNumber(value);
              return null;
            },
          ),
          CustomDropdownSearchFieldWidget(
            prefixIconData: Icons.fingerprint,
            hintText: 'Select Device',
            searchFieldHintText: 'Select Device',
            showSearchBox: false,
            listItems: devicesMap,
            onChange: (Map<String, dynamic>? value) {
              selectedDevice = value?['value'];
              Logger().i('RD DEVICE PACKAGE NAME: ${value?['value']}');
              captureBiometric(selectedDevice);
              // log(value?['value']);
            },
          ),

          // const CustomDropdownWidget(list: ['Mantra', 'Startek'],),
          // Text(biometricData),
          const Spacer(),

          CustomCtaButton(
            label: 'Proceed',
            // BuildContext context, String mobile, String agentId, String aadhar, String biometricData, String kycToken, String wadh
            // onTap: moveToUpload(
            //   context,
            //   widget.mobile,
            //   widget.agentId,
            //   aadharController.text.trim(),
            //   biometricData,
            //   widget.kycToken,
            //   widget.wadh,
            // ),
          ),

          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          //   width: 400.0,
          //   height: 50.0,
          //   decoration: BoxDecoration(
          //     color: Colors.indigo.shade500,
          //     border: Border.all(
          //       color: Colors.indigo.shade500,
          //     ),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: const Center(
          //     child: Text(
          //       'Scan',
          //       style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
