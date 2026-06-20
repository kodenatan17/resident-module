import 'package:core_module/injection/core_injection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'resident_injection.config.dart';
import '../application/repositories/auth_repository_impl.dart';
import '../application/services/auth_service.dart';
import '../domain/repositories/auth_repository.dart';
import '../infrastructure/datasource/auth_remote_datasource.dart';
import '../presentation/bloc/auth_bloc.dart';

@InjectableInit(
  initializerName: 'initResident',
  preferRelativeImports: true,
  asExtension: true,
)
void setupResidentInjection() {
  getIt.initResident();

  // ── Auth Dependencies (manual) ──────────────────────
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://api.rt-rw-digital.example.com/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      )));
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<AuthRepository>()),
  );
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authService: getIt<AuthService>()),
  );
}
