import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  void initState() {
    // context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Doctor Home Page',
      bottomNavigationBar: doctorBottomNavigationBar,
      drawer: const DefaultDoctorDrawer(),
      child: ElevatedButton(
        child: const Text('Profile'),
        onPressed: () {
          doctorBottomNavigationBar.navigateTo(2);
        },
      ),
    );
  }
}
