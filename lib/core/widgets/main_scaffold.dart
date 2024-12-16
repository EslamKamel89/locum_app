import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/default_screen_padding.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.appBarTitle,
    required this.child,
    required this.bottomNavigationBar,
    required this.drawer,
  });
  final String appBarTitle;
  final Widget child;
  final Widget bottomNavigationBar;
  final Widget drawer;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
        body: DefaultScreenPadding(
          child: child,
        ),
      ),
    );
  }
}
