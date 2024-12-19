import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.prefixIcon,
      this.obscureText = false,
      this.validator,
      this.onChanged});
  final String labelText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText && !showPassword,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                      showPassword
                          ? MdiIcons.eyeOffOutline
                          : MdiIcons.eyeOutline,
                      color: context.primaryColor),
                );
              })
            : null,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}
