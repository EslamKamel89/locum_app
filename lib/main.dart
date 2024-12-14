import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl_standalone.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/router/app_router.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/core/themes/theme_cubit.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await findSystemLocale();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/langs', // Path to translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => UserInfoCubit(commonDataRepo: serviceLocator())),
        ],
        child: Builder(builder: (context) {
          final themeCubit = context.watch<ThemeCubit>();
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: themeCubit.state,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutesNames.splashScreen,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: serviceLocator<AppRouter>().onGenerateRoute,
          );
        }),
      ),
    );
  }
}
