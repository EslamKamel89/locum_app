import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/utils/assets/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late UserInfoCubit userInfoCubit;
  @override
  void initState() {
    super.initState();
    userInfoCubit = context.read<UserInfoCubit>();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        userInfoCubit.fetchUserInfo(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Icon(
                  //   Icons.view_compact_alt_rounded,
                  //   size: 100,
                  //   color: context.primaryColor,
                  // ),
                  Image.asset(AssetsData.logo)
                ],
              ),
            ),

            // FadeTransition(
            //   opacity: _animation,
            //   child: const Text(
            //     'AM PM\nHealth Care Stafing',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 28,
            //       height: 1,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            // Subtitle
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Your Gateway to\nFlexible Healthcare Work',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
