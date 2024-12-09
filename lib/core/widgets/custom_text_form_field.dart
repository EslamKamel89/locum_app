import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.obscureText,
  });
  final String labelText;
  final Widget? prefixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}
