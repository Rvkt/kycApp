import 'package:flutter/material.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController(text: '8860733786');
  TextEditingController passwordController = TextEditingController(text: 'O79IKA');

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
                  const CustomTextFormField(labelText: 'Mobile', keyboardType: TextInputType.number),
                  const CustomTextFormField(labelText: 'Password', keyboardType: TextInputType.visiblePassword),
                  const CustomDropdownWidget(),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: checkBoxValue,
                              activeColor: Colors.indigo.shade500,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  checkBoxValue = newValue!;
                                });
                              },
                            ),
                            Text(
                              'By creating an account you are agreeing to our',
                              style: TextStyle(
                                color: checkBoxValue ? Colors.indigo.shade500 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Our Terms and conditions',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: checkBoxValue ? Colors.indigo.shade500 : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                        'Login',
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.45),
              child: const Divider(thickness: 2,),
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
}
