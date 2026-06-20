import 'package:go_router/go_router.dart';
import 'package:core_module/core_module.dart';

import '../injection/resident_injection.dart';
import '../manifest/manifest.dart';
import '../routes/resident_routes.dart';

/// FeatureModule implementation for the Resident module.
class ResidentModule extends FeatureModule {
  @override
  String get name => 'resident';

  @override
  String get displayName => 'Resident Management';

  @override
  ModuleVersion get version => ModuleVersion(1, 0, 0);

  @override
  ModuleManifest get manifest => residentManifest;

  @override
  List<ModulePermission> get permissions => residentManifest.permissions;

  @override
  Future<void> initialize() async {
    // Async initialization: DB migrations, preloading, etc.
    // Currently no-op — extend as needed.
  }

  @override
  void setupDependencies() {
    setupResidentInjection();
  }

  @override
  List<RouteBase> get routes => ResidentRoutes.all;
}
