import 'package:flutter/material.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/utils/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalHomeScreen extends StatelessWidget {
  const HospitalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Home View'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await serviceLocator<SharedPreferences>().clear();
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.signinScreen, (_) => false);
            },
            child: txt('Log out')),
      ),
    );
  }
}
