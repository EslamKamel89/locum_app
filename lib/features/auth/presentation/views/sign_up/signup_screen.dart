import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/enums/user_type_enum.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/heleprs/validator.dart';
import 'package:locum_app/core/widgets/custom_text_form_field.dart';
import 'package:locum_app/core/widgets/default_screen_padding.dart';
import 'package:locum_app/core/widgets/dropdown_widget.dart';
import 'package:locum_app/core/widgets/searchable_dropdown_widget.dart';
import 'package:locum_app/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:locum_app/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _collectData() => {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "passwordConfirm": _passwordConfirmController.text,
      };
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            final controller = context.read<SignUpCubit>();
            return Form(
              key: _formKey,
              child: DefaultScreenPadding(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        txt("Create an Account",
                            e: St.bold25, textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        txt("Sign up to get started",
                            e: St.reg16,
                            c: Colors.grey,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          labelText: "Full Name",
                          prefixIcon: const Icon(Icons.person_outline),
                          controller: _nameController,
                          validator: (input) => valdiator(
                            input: input,
                            label: 'Full Name',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          labelText: "Email Address",
                          prefixIcon: const Icon(Icons.email_outlined),
                          controller: _emailController,
                          validator: (input) => valdiator(
                            input: input,
                            label: 'Email',
                            isRequired: true,
                            isEmail: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          obscureText: true,
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          controller: _passwordController,
                          validator: (input) => valdiator(
                            input: input,
                            label: 'Password',
                            isRequired: true,
                            minChars: 5,
                            maxChars: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                            obscureText: true,
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            controller: _passwordConfirmController,
                            validator: (input) {
                              return valdiator(
                                input: input,
                                label: 'Confirm Password',
                                isRequired: true,
                                minChars: 5,
                                maxChars: 50,
                                isConfirmPassword: true,
                                firstPassword: _passwordController.text,
                              );
                            }),
                        const SizedBox(height: 20),
                        SearchableDropdownWidget(
                          label: 'State',
                          hintText: 'Select State',
                          isRequired: true,
                          options: state.states
                                  ?.map((stateModel) => stateModel.name ?? '')
                                  .toList() ??
                              [],
                          handleSelectOption: (String option) {
                            controller.fetchDistrict(option);
                          },
                        ),
                        state.districtsDataModel == null
                            ? const SizedBox()
                            : const SizedBox(height: 20),
                        state.districtsDataModel == null
                            ? const SizedBox()
                            : SearchableDropdownWidget(
                                label: 'District (Optional)',
                                hintText: 'Select District',
                                isRequired: false,
                                options: state.districtsDataModel?.districts
                                        ?.map((districtModel) =>
                                            districtModel?.name ?? '')
                                        .toList() ??
                                    [],
                                handleSelectOption: (String option) {
                                  controller.selectDistrict(option);
                                },
                              ),
                        const SizedBox(height: 20),
                        DropDownWidget(
                          options: UserTypeEnum.values
                              .map((userType) => userType.toFullString())
                              .toList(),
                          label: 'Healthcare Provider or Professional',
                          onSelect: (String? value) {
                            if (value == null) return;
                            controller.selectUserType(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        state.responseType == ResponseType.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    controller.signUp(
                                      SignUpParams(
                                        name: _collectData()['name'],
                                        email: _collectData()['email'],
                                        password: _collectData()['password'],
                                        districtId: state.selectdDistrict?.id,
                                        stateId: state.selectedState?.id,
                                        userType: state.selectedUserType,
                                      ),
                                    );
                                  }
                                },
                                child: txt("Sign Up", e: St.reg16),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Divider(thickness: 1)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: txt("OR", c: Colors.grey),
                            ),
                            const Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle Google sign-up
                          },
                          style: context.outlinedButtonTheme.style,
                          icon: Icon(MdiIcons.google),
                          label: txt("Sign up with Google",
                              c: Colors.black, e: St.reg16),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            txt("Already have an account?", c: Colors.grey),
                            TextButton(
                              onPressed: () {
                                // Handle navigation to sign-in screen
                                Navigator.pop(
                                    context); // Navigate back to Sign In
                              },
                              child: txt("Sign In", c: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
