import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/utils/validators.dart';
import 'package:kyc_app/widgets/custom_dropdown_search_field_widget.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

const platform = MethodChannel('com.softmintinidia.softmint/my_channel');

class MerchantFingerCaptureScreen extends StatefulWidget {
  final String mobile;
  final String agentId;

  // final String aadhar;
  final String kycToken;

  const MerchantFingerCaptureScreen({super.key, required this.mobile, required this.agentId, required this.kycToken});

  @override
  State<MerchantFingerCaptureScreen> createState() => _MerchantFingerCaptureScreenState();
}

class _MerchantFingerCaptureScreenState extends State<MerchantFingerCaptureScreen> {
  String biometricData = '';
  String wadh = '';

  // moveToUpload(BuildContext context, String mobile, String agentId, String aadhar, String biometricData, String kycToken, String wadh) async {
  //   final bankKycProvider = Provider.of<BankKycProvider>(context, listen: false);
  //   await bankKycProvider.yesBiometricKyc(context, mobile, agentId, aadhar, biometricData, kycToken, wadh);
  //   Logger().i(bankKycProvider.yesOtpCreationResponseModel);
  // }

  final List<Map<String, dynamic>> devicesMap = [
    {'value': 'com.acpl.registersdk', 'label': 'Startek'},
    {'value': 'com.scl.rdservice', 'label': 'Morpho'},
    {'value': 'com.nextbiometrics.onetouchrdservic', 'label': 'NEXT Biometrics OneTouch L0'},
    {'value': 'com.mantra.rdservice', 'label': 'Mantra'},
    {'value': 'com.precision.pb510.rdservice', 'label': 'Precision'},
  ];
  TextEditingController aadharController = TextEditingController();


  // void checkRdStatus(String deviceName) {
  //   Logger().i("$deviceName is selected...");
  //   platform.invokeMethod('checkBiometricStatus', {
  //     'package': getPackageForDevice(deviceName),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
            validator: (value){
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
              Logger().i('Selected Bank Value: ${value?['label']}');
              // log(value?['value']);
            },
          ),

          // const CustomDropdownWidget(list: ['Mantra', 'Startek'],),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            width: 400.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.indigo.shade500,
              border: Border.all(
                color: Colors.indigo.shade500,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Scan',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
