import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';

class DoctorProfileView extends StatefulWidget {
  const DoctorProfileView({super.key});

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      appBarTitle: 'Doctor Profile',
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
