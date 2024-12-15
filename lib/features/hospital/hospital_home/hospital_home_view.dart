import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/utils/styles/styles.dart';

class HospitalHomeScreen extends StatefulWidget {
  const HospitalHomeScreen({super.key});

  @override
  State<HospitalHomeScreen> createState() => _HospitalHomeScreenState();
}

class _HospitalHomeScreenState extends State<HospitalHomeScreen> {
  @override
  void initState() {
    // context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Home View'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              context.read<UserInfoCubit>().handleSignOut();
            },
            child: txt('Log out')),
      ),
    );
  }
}
