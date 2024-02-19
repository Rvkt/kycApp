import 'package:flutter/material.dart';

class CustomCtaButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const CustomCtaButton({super.key, this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
