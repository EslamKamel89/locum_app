import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/default_screen_padding.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.appBarTitle,
    required this.child,
  });
  final String appBarTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        bottomNavigationBar: doctorBottomNavigationBar,
        body: DefaultScreenPadding(
          child: child,
        ),
      ),
    );
  }
}
