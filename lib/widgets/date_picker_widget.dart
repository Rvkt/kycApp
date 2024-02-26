import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatePicker extends StatefulWidget {
  final Function(String)? onDateSelected;

  const DatePicker({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? picked;
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Retrieve saved dates from shared preferences
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1950),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        picked = selectedDate;
      });

      // Format date as 'yyyy-MM-dd'
      String formattedDate = '${picked!.day.toString().padLeft(2, '0')}/${picked!.month.toString().padLeft(2, '0')}/${picked!.year}';
      Logger().i(formattedDate);
      // Pass formatted date to the callback function
      widget.onDateSelected?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            picked != null
                ? '${picked!.day.toString().padLeft(2, '0')}-${picked!.month.toString().padLeft(2, '0')}-${picked!.year}'
                : 'Date of Birth',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.indigo.shade600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
