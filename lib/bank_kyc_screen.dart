import 'package:flutter/material.dart';
import 'package:kyc_app/widgets/custom_text_form_field_widget.dart';

class BankKycScreen extends StatefulWidget {
  const BankKycScreen({super.key});

  @override
  State<BankKycScreen> createState() => _BankKycScreenState();
}

class _BankKycScreenState extends State<BankKycScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bank KYC'),
        backgroundColor: Colors.indigo.shade400,
      ),
      body: Column(
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
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'First Name',
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'Last Name',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'Date of Birth',
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'Gender',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'City',
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'State',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'Mobile',
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
                child: const CustomTextFormField(
                  labelText: 'Pincode',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          const CustomTextFormField(
            labelText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const CustomTextFormField(
            labelText: 'Residential Address',
            keyboardType: TextInputType.multiline,
          ),
          const CustomTextFormField(
            labelText: 'Shop Name',
            keyboardType: TextInputType.text,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.84,
                child: const CustomTextFormField(
                  labelText: 'Pan Number',
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade400,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.arrow_circle_right_rounded, color: Colors.grey.shade100,),
                ),
              ),
            ],
          ),

        ],
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
