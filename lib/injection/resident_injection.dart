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
  // Dio already registered by core_module — reuse it.
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
