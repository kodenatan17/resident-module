# Resident Module

Feature module for resident data management in the RT-RW Digital system.
Implements the `FeatureModule` contract from `core_module` — self-describing, self-registering, with own routes and DI.

> **Note:** Authentication (login, OTP, session) has been extracted to a separate `authentication_module`.
> See `../authentication_module/README.md`.

---

## Package Structure

```
lib/
├── resident_module.dart                       # Barrel exports
├── public_api.dart                            # Domain abstractions (entities, repos)
├── manifest/
│   └── manifest.dart                          # ModuleManifest (lazy, optional)
├── module/
│   └── resident_module_definition.dart        # FeatureModule implementation
├── domain/
│   ├── entities/
│   │   └── resident.dart                      # Resident entity + ResidentStatus enum
│   └── repositories/
│       └── resident_repository.dart           # Abstract resident CRUD contract
├── application/
│   ├── models/
│   │   └── resident_model.dart                # Resident JSON model
│   ├── repositories/
│   │   └── resident_repository_impl.dart      # In-memory resident store
│   └── usecases/                              # Use cases (extendable)
├── infrastructure/
│   ├── dto/                                   # Infrastructure DTOs
│   ├── mapper/                                # Entity <-> DTO mappers
│   └── repositories/                          # Infra repository impls
├── injection/
│   ├── resident_injection.dart                # DI setup
│   └── resident_injection.config.dart         # Generated
├── routes/
│   └── resident_routes.dart                   # GoRouter route definitions
└── presentation/
    ├── pages/
    │   ├── resident_list_page.dart            # Resident list screen
    │   ├── resident_detail_page.dart          # Resident detail screen
    │   └── resident_create_page.dart          # Create resident form
    └── widgets/                               # Reusable widgets (extendable)
```

---

## Manifest

Declared in `lib/manifest/manifest.dart`:

| Field                      | Value                                      |
|----------------------------|--------------------------------------------|
| `name`                     | `"resident"`                               |
| `displayName`              | `"Resident Management"`                    |
| `version`                  | `1.0.0`                                    |
| `description`              | Manage resident profiles, phone numbers, and email addresses |
| `minShellVersion`          | `1.0.0`                                    |
| `initializationStrategy`   | `ModuleInitializationStrategy.lazy`        |
| `startupBehavior`          | `StartupBehavior.optional`                 |
| `defaultEnabled`           | `true`                                     |
| `defaultVisible`           | `true`                                     |
| Dependencies               | `core_module ^1.0.0`                       |
| Provides                   | `resident.crud`                            |

---

## Routes

```dart
/resident              → ResidentListPage
/resident/:id          → ResidentDetailPage
/resident/create       → ResidentCreatePage
```

Routes auto-register into the shell's GoRouter via `registry.allRoutes`.

---

## Resident CRUD

### Entity

```dart
class Resident {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String? address;
  final ResidentStatus status; // active | inactive | pending
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Repository

```dart
abstract class ResidentRepository {
  Future<List<Resident>> getAll();
  Future<Resident?> getById(String id);
  Future<Resident?> getByPhone(String phoneNumber);
  Future<Resident?> getByEmail(String email);
  Future<void> save(Resident resident);
  Future<void> update(Resident resident);
  Future<void> delete(String id);
}
```

Current implementation (`ResidentRepositoryImpl`) is in-memory. Future versions will use a remote API + local DB.

---

## Initialization

The resident module is initialized **lazily** — on first user navigation to a resident route.

### Bootstrap Participation

```
AppBootstrap.run()
  ↓
Register All Modules          → ResidentModule registered
  ↓
Load Cached Feature Flags     → check resident.enabled / resident.visible
  ↓
DI Setup                      → setupResidentInjection() called
  ↓
Init Eager Modules             → (skipped — resident is lazy)
  ↓
App Ready ✅
  ↓  (on first access)
ResidentModule.initialize()   → triggered by route resolution
```

### Lifecycle States

| Phase          | `isInitialized` | Behavior                                  |
|----------------|-----------------|-------------------------------------------|
| Registered     | `false`         | Metadata/routes available, DI not yet set |
| DI Setup       | `false`         | GetIt wired                               |
| Initialized    | `true`          | DB migrated, preload complete             |
| Disposed       | `false`         | Resources released, re-initializable      |

### Enable/Visible Resolution

```
resident.enabled  ← FeatureFlagService (remote → cache) → manifest defaultEnabled (true)
resident.visible  ← FeatureFlagService (remote → cache) → manifest defaultVisible (true)
```

The module is **always enabled by default**. Remote flags from GrowthBook can
override at runtime. Cache persists flags across cold starts.

---

## Module Definition

`lib/module/resident_module_definition.dart` implements `FeatureModule`:

| Override              | Implementation                         |
|-----------------------|----------------------------------------|
| `name`                | `"resident"`                           |
| `displayName`         | `"Resident Management"`                |
| `version`             | `ModuleVersion(1, 0, 0)`               |
| `manifest`            | `residentManifest`                     |
| `isInitialized`       | Returns `_initialized` flag            |
| `initialize()`        | Sets `_initialized = true` (extendable)|
| `dispose()`           | Resets `_initialized = false`          |
| `setupDependencies()` | Calls `setupResidentInjection()`       |
| `routes`              | `ResidentRoutes.all`                   |

---

## Dependencies

| Package           | Purpose                     |
|-------------------|-----------------------------|
| `core_module`     | Contracts, base classes, Dio|
| `flutter_bloc`    | State management            |
| `go_router`       | Routing                     |
| `get_it`          | DI                          |
| `injectable`      | DI code generation          |
| `retrofit`        | API client generation       |
| `dio`             | HTTP client                 |
| `equatable`       | Value equality              |

---

## How to Add a New Feature

1. **Entity** — add/update fields in `domain/entities/`
2. **Repository** — add methods to abstract repo, implement in `application/repositories/`
3. **Use Case** — create in `application/usecases/` using `UseCaseWithParams` or `UseCase`
4. **BLoC** — create in `presentation/bloc/`
5. **Page** — create in `presentation/pages/`, add route in `routes/resident_routes.dart`
6. **DI** — register new classes in `injection/resident_injection.dart`
7. **Public API** — export new domain abstractions in `public_api.dart`
