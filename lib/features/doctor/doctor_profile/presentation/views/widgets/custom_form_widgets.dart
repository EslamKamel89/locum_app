import 'package:flutter/material.dart';

class CustomDateField extends StatefulWidget {
  CustomDateField(
    this.label,
    this.selectedDate, {
    super.key,
    required this.licenseIssueDate,
    required this.licenseExpiryDate,
    required this.isIssueDate,
  });
  final String label;
  final DateTime? selectedDate;
  final bool isIssueDate;
  DateTime licenseIssueDate;
  DateTime licenseExpiryDate;
  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context, isIssueDate: widget.isIssueDate),
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.selectedDate != null
                  ? '${widget.selectedDate?.year}-${widget.selectedDate?.month.toString().padLeft(2, '0')}-${widget.selectedDate?.day.toString().padLeft(2, '0')}'
                  : 'Select a date',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            validator: (_) => widget.selectedDate == null
                ? '${widget.label} is required'
                : null,
          ),
        ),
      ),
    );
  }

  // Method to pick a date
  Future<void> _selectDate(BuildContext context,
      {required bool isIssueDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isIssueDate) {
          widget.licenseIssueDate = pickedDate;
        } else {
          widget.licenseExpiryDate = pickedDate;
        }
      });
    }
  }
}

class CustomBiographyForm extends StatelessWidget {
  const CustomBiographyForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Biography',
          hintText: 'Write a brief biography',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label,
    this.controller,
    this.hint, {
    super.key,
    this.inputType = TextInputType.text,
  });
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '$label is required' : null,
      ),
    );
  }
}
