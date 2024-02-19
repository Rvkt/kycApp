import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateRangePicker extends StatefulWidget {
  final VoidCallback? func;

  const DateRangePicker({Key? key, this.func}) : super(key: key);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Retrieve saved dates from shared preferences
    _getSavedDates();
  }

  void _getSavedDates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Check if the preferences already exist
    if (preferences.containsKey('fromDate') && preferences.containsKey('toDate')) {
      // Remove existing preferences
      preferences.remove('fromDate');
      preferences.remove('toDate');
    }

    // Set new preferences
    setState(() {
      fromDate = preferences.getString('fromDate') != null
          ? DateTime.parse(preferences.getString('fromDate')!)
          : DateTime.now(); // Set to current date if not available
      toDate = preferences.getString('toDate') != null
          ? DateTime.parse(preferences.getString('toDate')!)
          : DateTime.now(); // Set to current date if not available
    });
  }


  void setSharedPreferences(String key, dynamic value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is String) {
      preferences.setString(key, value);
    } else {
      throw Exception('Unsupported Value type');
    }
  }

  Future<DateTime?> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: fromDate ?? currentDate,
      initialDate: currentDate,
      firstDate: DateTime(2022),
      lastDate: currentDate,
    );
    if (picked != null) {
      setState(() {
        fromDate = picked;
        if (toDate != null && fromDate!.isAfter(toDate!)) {
          toDate = fromDate; // Ensure to-date is not before from-date
        }
      });

      // Store fromDate in shared preferences as a timestamp
      setSharedPreferences('fromDate', '${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}');
    }
    return fromDate;
  }


  Future<DateTime?> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: toDate ?? currentDate,
      initialDate: currentDate,
      firstDate: fromDate ?? DateTime(2022), // Set firstDate to from-date if available
      lastDate: currentDate,
    );
    if (picked != null) {
      setState(() {
        toDate = picked;

      });
    }
    if (fromDate != null && toDate != null) {
      // log('${fromDate?.toLocal().toIso8601String().split('T')[0]}', name: 'From Date');
      // log('${toDate?.toLocal().toIso8601String().split('T')[0]}', name: 'To Date');
      setSharedPreferences('toDate', '${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}');
      widget.func!();

    } else {
      log('Dates not selected');
    }
    return toDate;
  }

  // void _clearDates() {
  //   setState(() {
  //     fromDate = null;
  //     toDate = null;
  //   });
  // }
  //
  // void _showDates() {
  //   if (fromDate != null && toDate != null) {
  //     log('${fromDate?.toLocal().toIso8601String().split('T')[0]}', name: 'Date');
  //     log('${toDate?.toLocal().toIso8601String().split('T')[0]}', name: 'Time');
  //
  //   } else {
  //     log('Dates not selected');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // IconButton(
              //   onPressed: () => _selectFromDate(context),
              //   icon: const Icon(
              //     Icons.calendar_month,
              //     size: 36,
              //     color: Color.fromRGBO(37, 65, 89, 1),
              //   ),
              // ),
              GestureDetector(
                onTap: () => _selectFromDate(context),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.shade100,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      fromDate != null
                          ? '${fromDate!.day.toString().padLeft(2, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.year}'
                          : 'dd-mm-yyyy',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,

                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // IconButton(
              //   onPressed: () => _selectToDate(context),
              //   icon: const Icon(
              //     Icons.calendar_month,
              //     size: 30,
              //     color: Color.fromRGBO(37, 65, 89, 1),
              //   ),
              // ),
              GestureDetector(
                onTap: () => _selectToDate(context),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.shade100,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      toDate != null
                          ? '${toDate!.day.toString().padLeft(2, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.year}'
                          : 'dd-mm-yyyy',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: Container(
              //     height: 40,
              //     decoration: BoxDecoration(
              //       color: const Color.fromRGBO(37, 65, 89, 1),
              //       border: const Border.fromBorderSide(BorderSide.none),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: Center(
              //       child: TextButton(
              //         onPressed: _showDates,
              //         child: const Text(
              //           'Show',
              //           style: TextStyle(
              //             letterSpacing: 1,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     TextButton(
        //       onPressed: _clearDates,
        //       child: const Text(
        //         'Clear Dates',
        //         style: TextStyle(
        //           color: Colors.grey,
        //           decoration: TextDecoration.underline,
        //           fontSize: 12,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
