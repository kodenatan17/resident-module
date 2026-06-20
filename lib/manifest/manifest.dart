import 'package:core_module/core_module.dart';

/// Resident module manifest metadata.
final ModuleManifest residentManifest = ModuleManifest(
  name: 'resident',
  displayName: 'Resident Management',
  version: ModuleVersion(1, 0, 0),
  description: 'Manage resident profiles, phone numbers, and email addresses',
  minShellVersion: ModuleVersion(1, 0, 0),
  recommendedShellVersion: ModuleVersion(1, 0, 0),
  permissions: [
    ModulePermission(
      name: 'resident.read',
      description: 'View resident profiles and contact information',
    ),
    ModulePermission(
      name: 'resident.write',
      description: 'Create and update resident profiles',
    ),
    ModulePermission(
      name: 'resident.delete',
      description: 'Remove resident profiles',
    ),
    ModulePermission(
      name: 'auth.login',
      description: 'Login with phone and password',
    ),
    ModulePermission(
      name: 'auth.verify',
      description: 'Verify OTP for registration',
    ),
  ],
  dependencies: [
    ModuleDependency(
      moduleName: 'core_module',
      minVersion: ModuleVersion(1, 0, 0),
    ),
  ],
  featureFlags: {
    'resident.enabled': true,
    'resident.visible': true,
    'resident.export': false,
  },
  provides: [
    'resident.crud',
    'resident.search',
    'resident.auth',
  ],
);
