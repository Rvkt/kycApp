import 'package:flutter/material.dart';
import 'package:kyc_app/models/response_models/login_response.dart';
import 'package:kyc_app/providers/auth_provider.dart';
import 'package:kyc_app/utils/validators.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoginButtonDisabled = false;
  TextEditingController mobileController = TextEditingController(text: '8920209759');
  TextEditingController passwordController = TextEditingController(text: 'IJ661S');

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 48, top: 54, bottom: 24),
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.indigo.shade600,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 48, bottom: 24),
              child: Image.asset(
                'assets/logo/logo.png',
                width: screenWidth * 0.6,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Text(
                    'Hello, there',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Welcome to Softmint',
                    style: TextStyle(
                      color: Colors.indigo.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Mobile',
                    keyboardType: TextInputType.number,
                    validator: validateUsername,
                    controller: mobileController,
                  ),
                  CustomTextFormField(
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                    controller: passwordController,
                  ),
                  const CustomDropdownWidget(
                    list: ['Distributor', 'Employee'],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    // color: Colors.red,
                    child: Column(
                      children: [
                        SizedBox(
                          // padding: EdgeInsets.symmetric(horizontal: 16),
                          width: screenWidth,
                          child: Row(
                            children: [
                              Checkbox(
                                value: checkBoxValue,
                                activeColor: Colors.indigo.shade500,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    checkBoxValue = newValue!;
                                  });
                                },
                                visualDensity: VisualDensity.compact,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Terms & Conditions',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: checkBoxValue ? Colors.indigo.shade500 : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: Text(
                        //         'Our Terms and conditions',
                        //         textAlign: TextAlign.start,
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           color: checkBoxValue ? Colors.indigo.shade500 : Colors.black54,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  CustomCtaButton(
                    label: 'Login',
                    onTap: () {
                      bool validate = _formKey.currentState!.validate();
                      if (validate) {
                        if (checkBoxValue) {
                          Logger().i('Form is Validated');
                          loginUser(
                            context,
                            mobileController.text.trim(),
                            passwordController.text.trim(),
                          );
                        } else {
                          Logger().i('You Are required to accept to the Our Terms and conditions');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.45),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account"),
                TextButton(
                  onPressed: () {},
                  child: const Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loginUser(BuildContext context, String mobile, String password) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    LoginResponse? loginResponse = await authProvider.authenticateUser(context, mobile, password);

    // Logger().i(loginResponse?.status);

    setState(() {
      _isLoginButtonDisabled = false;
    });
  }
}
