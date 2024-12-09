import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/heleprs/validator.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/widgets/custom_text_form_field.dart';
import 'package:locum_app/core/widgets/default_screen_padding.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:locum_app/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _collectData() => {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final controller = context.read<SignInCubit>();
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: DefaultScreenPadding(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      txt("Welcome Back!", e: St.bold25, textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      txt("Sign in to continue", e: St.reg16, c: Colors.grey, textAlign: TextAlign.center),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: "Email Address",
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (String? value) {
                          return valdiator(
                            input: value,
                            label: 'Email',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                            isEmail: true,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        validator: (String? value) {
                          return valdiator(
                            input: value,
                            label: 'Password',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          );
                        },
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.signIn(signInData: _collectData());
                          }
                        },
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
            ),
          ),
        );
      },
    );
  }
}
