import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/dio_consumer.dart';
import 'package:locum_app/core/router/app_router.dart';
import 'package:locum_app/core/router/middleware.dart';
import 'package:locum_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:locum_app/features/auth/data/repos/auth_repo_imp.dart';
import 'package:locum_app/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_app/features/common_data/data/data_source/common_data_remote_source.dart';
import 'package:locum_app/features/common_data/data/repos/common_data_repo_imp.dart';
import 'package:locum_app/features/common_data/domain/repos/common_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt serviceLocator = GetIt.instance;

Future initServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<AppMiddleWare>(() => AppMiddleWare(sharedPreferences: serviceLocator()));
  serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter(appMiddleWare: serviceLocator()));

  serviceLocator.registerLazySingleton<CommonDataRemoteSource>(() => CommonDataRemoteSource(api: serviceLocator()));
  serviceLocator
      .registerLazySingleton<CommonDataRepo>(() => CommonDataRepoImp(commonDataRemoteSource: serviceLocator()));
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(api: serviceLocator()));
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepoImp(authRemoteDataSource: serviceLocator()));
}
