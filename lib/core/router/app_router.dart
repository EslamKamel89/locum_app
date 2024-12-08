import 'package:flutter/material.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/router/middleware.dart';
import 'package:locum_app/features/auth/presentation/views/sign_in/sign_in_screen.dart';
import 'package:locum_app/features/auth/presentation/views/sign_up/signup_screen.dart';
import 'package:locum_app/features/splash_onboarding/presention/views/on_bording_screen.dart';
import 'package:locum_app/features/splash_onboarding/presention/views/splash_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.onboardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signinScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signupScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}
