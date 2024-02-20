import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropdownSearchFieldWidget extends StatefulWidget {
  final String hintText;
  final String? searchFieldHintText;
  final List<Map<String, dynamic>> listItems;
  final IconData? prefixIconData;
  final Function(Map<String, dynamic>?)? onChange;
  final bool showSearchBox;
  final Function(Map<String, dynamic>?)? validator;
  final Map<String, dynamic>? selectedItem;

  const CustomDropdownSearchFieldWidget({
    super.key,
    required this.hintText,
    required this.listItems,
    this.prefixIconData,
    this.onChange,
    required this.showSearchBox,
    this.searchFieldHintText,
    this.validator,
    this.selectedItem,
  });

  @override
  State<CustomDropdownSearchFieldWidget> createState() => _CustomDropdownSearchFieldWidgetState();
}

class _CustomDropdownSearchFieldWidgetState extends State<CustomDropdownSearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownSearch<Map<String, dynamic>>(
        selectedItem: widget.selectedItem,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            color: Colors.indigo.shade400,
          ),
          dropdownSearchDecoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(widget.prefixIconData),
            prefixIconColor: Colors.indigo.shade400,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.indigo.shade400),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 16, top: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo.shade400.withAlpha(50),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.indigo.shade400,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              gapPadding: 4,
              borderSide: BorderSide(color: Colors.indigo.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onChanged: widget.onChange,
        items: widget.listItems,
        itemAsString: (Map<String, dynamic> item) => item['label'].toString(),
        popupProps: PopupProps.menu(
          menuProps: MenuProps(
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.white.withOpacity(1),
            shadowColor: Colors.black87,
          ),
          scrollbarProps: ScrollbarProps(
            thumbColor: Colors.indigo.shade400,
            radius: const Radius.circular(10),
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: widget.searchFieldHintText,
              hintStyle: TextStyle(
                color: Colors.indigo.shade400.withOpacity(0.3),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   borderSide: const BorderSide(
              //     color: Colors.black87,
              //   ),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   borderSide: BorderSide(
              //     color: lightColorScheme.primary,
              //     width: 1,
              //   ),
              // ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              // ),
            ),
          ),
          showSearchBox: widget.showSearchBox,
          fit: FlexFit.tight,
          // constraints: BoxConstraints.tight(Size(width, height * 0.25)),
          constraints: BoxConstraints.tightFor(width: width, height: height * 0.5),
        ),
      ),
    );
  }
}
