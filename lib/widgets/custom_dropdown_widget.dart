import 'package:flutter/material.dart';
// const List<String> list = <String>['Distributor', 'Employee'];

class CustomDropdownWidget extends StatefulWidget {
  final List<String> list;
  final Function(String?)? onChanged;

  const CustomDropdownWidget({Key? key, required this.list, this.onChanged}) : super(key: key);

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

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
          onChanged: widget.onChanged,

          // onChanged: (String? value) {
          //   // This is called when the user selects an item.
          //   setState(() {
          //     dropdownValue = value!;
          //   });
          // },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
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