import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final Function(PointerDownEvent)? onTapOutside;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    this.validator,
    required this.keyboardType,
    this.onFieldSubmitted,
    this.onSaved,
    this.onEditingComplete,
    this.onChange,
    this.initialValue,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    final device = Device(context);
    double screenWidth = device.width;
    double screenHeight = device.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        // autofocus: true,
        // canRequestFocus: true,
        style: TextStyle(
          color: Colors.indigo.shade600,
        ),
        initialValue: initialValue,
        decoration: InputDecoration(
          label: Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.indigo.shade600,
            ),
          ),
          // prefixIcon: const Icon(Icons.phone_android),
          // prefixIconColor: Colors.indigo.shade600,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.indigo.shade600,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          isCollapsed: true,
        ),
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        onChanged: onChange,
        onTapOutside: onTapOutside,
        // autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
