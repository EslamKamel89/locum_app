import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/router/middleware.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:locum_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:locum_app/features/auth/presentation/views/sign_in/sign_in_screen.dart';
import 'package:locum_app/features/auth/presentation/views/sign_up/signup_screen.dart';
import 'package:locum_app/features/doctor/doctor_home/doctor_home_view.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/cubits/doctor/doctor_cubit.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/cubits/doctor_info/doctor_info_cubit.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/cubits/user_doctor/user_doctor_cubit.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/doctor_form.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/doctor_info_form.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/doctor_profile_view.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/user_doctor_form.dart';
import 'package:locum_app/features/hospital/hospital_home/hospital_home_view.dart';
import 'package:locum_app/features/splash_onboarding/presention/views/on_bording_screen.dart';
import 'package:locum_app/features/splash_onboarding/presention/views/splash_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>?;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.onboardingScreen:
        return CustomPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signinScreen:
        return CustomPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInCubit(authRepo: serviceLocator()),
            child: const SignInScreen(),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.signupScreen:
        return CustomPageRoute(
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
        return CustomPageRoute(
          builder: (context) => const HospitalHomeScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorHomeScreen:
        return CustomPageRoute(
          builder: (context) => const DoctorHomeScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorProfileScreen:
        return CustomPageRoute(
          builder: (context) => const DoctorProfileView(),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorInfoForm:
        return CustomPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DoctorInfoCubit(doctorProfileRepo: serviceLocator()),
            child: DoctorInfoForm(
              create: args?['create'] ?? true,
            ),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.doctorForm:
        return CustomPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DoctorCubit(serviceLocator()),
            child: DoctorForm(
              create: args?['create'],
            ),
          ),
          settings: routeSettings,
        );
      case AppRoutesNames.userDoctorForm:
        return CustomPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => UserDoctorCubit(serviceLocator()),
            child: const UserDoctorForm(),
          ),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
