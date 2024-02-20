import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kyc_app/models/response_models/bank_kyc_response_model.dart';
import 'package:kyc_app/providers/kyc_provider.dart';
import 'package:kyc_app/utils/validators.dart';
import 'package:kyc_app/widgets/custom_cta_button.dart';
import 'package:kyc_app/widgets/custom_dropdown_widget.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'widgets/date_picker_widget.dart';

class BankKycScreen extends StatefulWidget {
  const BankKycScreen({super.key});

  @override
  State<BankKycScreen> createState() => _BankKycScreenState();
}

class _BankKycScreenState extends State<BankKycScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  BankKycResponseModel? bankKycResponseModel;

  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';
  String gender = '';
  String city = '';
  String state = '';
  String mobile = '';
  String pincode = '';
  String email = '';
  String shopAddress = '';
  String shopName = '';
  String panNumber = '';
  String aadharNumber = '';

  Future<void> initiateAgent(
      BuildContext context,
      String firstName,
      String lastName,
      String shopAddress,
      String city,
      String state,
      String pincode,
      String shopName,
      String mobile,
      String dob,
      String gender,
      String pan,
      String email,
      String aadhaar,
      ) async {
    final bankKycProvider = Provider.of<BankKycProvider>(context, listen: false);
    await bankKycProvider.onboardAgent(
      context,
      firstName,
      lastName,
      shopAddress,
      city,
      state,
      pincode,
      shopName,
      mobile,
      dob,
      gender,
      pan,
      email,
      aadhaar,
    );
    Logger().i(bankKycProvider.bankKycResponseModel);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bank KYC'),
        backgroundColor: Colors.indigo.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Personal Details'),
                  Icon(
                    Icons.double_arrow_rounded,
                    size: 16,
                  ),
                  Text('ID Proof'),
                  Icon(
                    Icons.double_arrow_rounded,
                    size: 16,
                  ),
                  Text('Bank Details'),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'First Name',
                          keyboardType: TextInputType.text,
                          controller: firstNameController,
                          validator: validateName,
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              Logger().i(value);
                              setState(() {
                                firstName = value;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'Last Name',
                          keyboardType: TextInputType.text,
                          controller: lastNameController,
                          validator: validateName,
                          onChange: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: DatePicker(
                          onDateSelected: (date) {
                            setState(() {
                              dateOfBirth = date;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomDropdownWidget(
                          list: const ['Male', "Female", "Other"],
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'City',
                          keyboardType: TextInputType.text,
                          controller: cityController,
                          onChange: (value) {
                            setState(() {
                              city = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'State',
                          keyboardType: TextInputType.text,
                          controller: stateController,
                          onChange: (value) {
                            setState(() {
                              state = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'Mobile',
                          keyboardType: TextInputType.text,
                          controller: mobileController,
                          validator: validateUsername,
                          onChange: (value) {
                            setState(() {
                              mobile = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: CustomTextFormField(
                          labelText: 'Pincode',
                          keyboardType: TextInputType.number,
                          controller: pinCodeController,
                          validator: validatePinCode,
                          onChange: (value) {
                            setState(() {
                              pincode = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    labelText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: validateEmail,
                    onChange: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Shop Address',
                    keyboardType: TextInputType.multiline,
                    controller: shopAddressController,
                    onChange: (value) {
                      setState(() {
                        shopAddress = value;
                      });
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Shop Name',
                    keyboardType: TextInputType.text,
                    controller: shopNameController,
                    onChange: (value) {
                      setState(() {
                        shopName = value;
                      });
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Pan Number',
                    keyboardType: TextInputType.text,
                    controller: panNumberController,
                    validator: validatePanCard,
                    onChange: (value) {
                      setState(() {
                        panNumber = value;
                      });
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Aadhar Number',
                    keyboardType: TextInputType.number,
                    controller: aadharNumberController,
                    validator: validateAadharNumber,
                    onChange: (value) {
                      setState(() {
                        aadharNumber = value;
                      });
                    },
                  ),
                  CustomCtaButton(
                    label: 'Submit',
                    onTap: () {
                      bool validate = _formKey.currentState!.validate();
                      if (validate) {
                        initiateAgent(
                          context,
                          firstName,
                          lastName,
                          shopAddress,
                          city,
                          state,
                          pincode,
                          shopName,
                          mobile,
                          dateOfBirth,
                          gender,
                          panNumber,
                          email,
                          aadharNumber,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // Row(
            //   children: [
            //     SizedBox(
            //       width: screenWidth * 0.84,
            //       child: const CustomTextFormField(
            //         labelText: 'Pan Number',
            //         keyboardType: TextInputType.text,
            //       ),
            //     ),
            //     Container(
            //       width: screenWidth * 0.12,
            //       decoration: BoxDecoration(
            //         color: Colors.indigo.shade400,
            //         borderRadius: BorderRadius.circular(10)
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 12),
            //         child: Icon(Icons.arrow_circle_right_rounded, color: Colors.grey.shade100,),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      // body: const StepperExample(),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Personal Details'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Content for Step 1'),
          ),
        ),
        const Step(
          title: Text('ID Proof'),
          content: Text('Content for Step 2'),
        ),
        const Step(
          title: Text('Bank Info'),
          content: Text('Content for Step 3'),
        ),
      ],
    );
  }
}
