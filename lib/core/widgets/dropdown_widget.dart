import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/utils/styles/styles.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key, required this.options, required this.label, required this.onSelect});
  final List<String> options;
  final String label;
  final Function onSelect;
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: _decoration(widget.label),
      items: widget.options
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: txt(option),
              ))
          .toList(),
      onChanged: (String? value) {
        widget.onSelect(value);
        setState(() {
          selectedValue = value;
        });
      },
      validator: (value) => value == null ? 'Please Select A Value' : null,
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: context.inputDecorationTheme.labelStyle,
      hintStyle: context.inputDecorationTheme.hintStyle,
      border: context.inputDecorationTheme.border,
      enabledBorder: context.inputDecorationTheme.enabledBorder,
      focusedBorder: context.inputDecorationTheme.focusedBorder,
      contentPadding: context.inputDecorationTheme.contentPadding,
    );
  }
}
