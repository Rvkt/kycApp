import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatefulWidget {
  const CustomDropdownWidget({super.key});

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.indigo.shade500,
          ),
          elevation: 2,
          style: TextStyle(color: Colors.indigo.shade500, fontWeight: FontWeight.bold),
          underline: Container(
            height: 0,
            color: Colors.white,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
