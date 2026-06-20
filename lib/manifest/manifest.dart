import 'package:core_module/core_module.dart';

/// Resident module manifest metadata.
final ModuleManifest residentManifest = ModuleManifest(
  name: 'resident',
  displayName: 'Resident Management',
  version: ModuleVersion(1, 0, 0),
  description: 'Manage resident profiles, phone numbers, and email addresses',
  minShellVersion: ModuleVersion(1, 0, 0),
  recommendedShellVersion: ModuleVersion(1, 0, 0),

  // ── Init Strategy ─────────────────────────────────
  // Lazy: resident module is loaded on first access.
  initializationStrategy: ModuleInitializationStrategy.lazy,
  startupBehavior: StartupBehavior.optional,

  // ── Default Visibility ────────────────────────────
  defaultEnabled: true,
  defaultVisible: true,

  dependencies: [
    ModuleDependency(
      moduleName: 'core_module',
      minVersion: ModuleVersion(1, 0, 0),
    ),
  ],
);
