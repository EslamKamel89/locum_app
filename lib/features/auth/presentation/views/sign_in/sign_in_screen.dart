import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/widgets/custom_text_form_field.dart';
import 'package:locum_app/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              txt("Welcome Back!", e: St.bold25, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              txt("Sign in to continue", e: St.reg16, c: Colors.grey, textAlign: TextAlign.center),
              const SizedBox(height: 40),
              const CustomTextFormField(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 20),
              const CustomTextFormField(
                obscureText: true,
                labelText: "Password",
                prefixIcon: Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: txt("Forgot Password?", c: context.primaryColor),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: txt(
                  "Sign In",
                  e: St.reg16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: txt("OR", c: Colors.grey),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                style: context.outlinedButtonTheme.style,
                icon: Icon(MdiIcons.google),
                label: txt("Sign in with Google", c: Colors.black, e: St.reg16),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  txt("Don't have an account?", c: Colors.grey),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutesNames.signupScreen);
                    },
                    child: txt("Sign Up", c: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
