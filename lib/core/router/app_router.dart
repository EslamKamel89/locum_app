import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/router/middleware.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:locum_app/features/auth/presentation/views/sign_in/sign_in_screen.dart';
import 'package:locum_app/features/auth/presentation/views/sign_up/signup_screen.dart';
import 'package:locum_app/features/doctor/doctor_home_view.dart';
import 'package:locum_app/features/hospital/hospital_home_view.dart';
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
          builder: (context) => BlocProvider(
            create: (context) => SignInCubit(authRepo: serviceLocator()),
            child: const SignInScreen(),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.signupScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpCubit(
              commonDataRepo: serviceLocator(),
              authRepo: serviceLocator(),
            )..fetchStates(),
            child: const SignUpScreen(),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.hospitalHomeScreen:
        return MaterialPageRoute(
          builder: (context) => const HospitalHomeScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorHomeScreen:
        return MaterialPageRoute(
          builder: (context) => const DoctorHomeScreen(),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}
