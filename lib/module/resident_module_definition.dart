import 'package:go_router/go_router.dart';
import 'package:core_module/core_module.dart';

import '../injection/resident_injection.dart';
import '../manifest/manifest.dart';
import '../routes/resident_routes.dart';

/// FeatureModule implementation for the Resident module.
class ResidentModule extends FeatureModule {
  bool _initialized = false;

  @override
  String get name => 'resident';

  @override
  String get displayName => 'Resident Management';

  @override
  ModuleVersion get version => ModuleVersion(1, 0, 0);

  @override
  ModuleManifest get manifest => residentManifest;

  @override
  bool get isInitialized => _initialized;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    // Async initialization: DB migrations, preloading, etc.
    // Currently no-op — extend as needed.
    _initialized = true;
  }

  @override
  void dispose() {
    _initialized = false;
  }

  @override
  void setupDependencies() {
    setupResidentInjection();
  }

  @override
  List<RouteBase> get routes => ResidentRoutes.all;
}
