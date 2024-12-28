import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/themes/theme_cubit.dart';
import 'package:locum_app/core/widgets/default_screen_padding.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.appBarTitle,
    required this.child,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset,
    this.hideAppBar = false,
  });
  final String appBarTitle;
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool? resizeToAvoidBottomInset;
  final bool hideAppBar;
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<ThemeCubit>().isDarkMode();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hideAppBar ? Colors.transparent : null,
          title: Text(appBarTitle),
          foregroundColor: hideAppBar
              ? isDark
                  ? Colors.white
                  : Colors.black
              : null,
        ),
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        // drawer: drawer,
        endDrawer: drawer,
        body: DefaultScreenPadding(
          child: child,
        ),
      ),
    );
  }
}
