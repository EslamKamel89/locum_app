import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/view/widgets/filter_and_search_widget.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/view/widgets/job_adds_widget.dart';

class DoctorLocumView extends StatefulWidget {
  const DoctorLocumView({super.key});

  @override
  State<DoctorLocumView> createState() => _DoctorLocumViewState();
}

class _DoctorLocumViewState extends State<DoctorLocumView> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Locum Jobs',
      bottomNavigationBar: doctorBottomNavigationBar,
      drawer: const DefaultDoctorDrawer(),
      child: const Column(children: [
        SearchWidget(),
        Expanded(child: JobAddsWidget()),
      ]),
    );
  }
}
