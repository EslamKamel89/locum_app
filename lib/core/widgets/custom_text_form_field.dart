import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.obscureText,
    this.validator,
  });
  final String labelText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}
