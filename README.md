# Resident Module

Feature module for resident data management in the Smart RT/RW system.
Implements the `FeatureModule` contract from `core_module` — self-describing, self-registering, with own routes and DI.

---

## Package Structure

```
lib/
├── resident_module.dart                      # Barrel exports
├── public_api.dart                           # Domain abstractions (entities, repos)
├── manifest/
│   └── manifest.dart                         # ModuleManifest instance
├── module/
│   └── resident_module_definition.dart       # FeatureModule implementation
├── domain/
│   ├── entities/
│   │   └── resident.dart                     # Resident entity + ResidentStatus enum
│   └── repositories/
│       └── resident_repository.dart          # Abstract repository contract
├── application/
│   ├── dto/                                  # Data transfer objects (app layer)
│   ├── models/                               # App-level models
│   ├── repositories/                         # Repository impl abstractions
│   ├── services/                             # Business logic services
│   └── usecases/                             # Use cases
├── infrastructure/
│   ├── datasource/                           # Remote/local data sources
│   ├── dto/                                  # DTOs for serialization
│   ├── mapper/                               # Entity <-> DTO mappers
│   ├── models/                               # Infrastructure models
│   └── repositories/                         # Repository implementations
├── injection/
│   ├── resident_injection.dart               # DI setup
│   └── resident_injection.config.dart        # Generated
├── routes/
│   └── resident_routes.dart                  # GoRouter route definitions
└── presentation/
    ├── bloc/                                 # BLoC state management
    ├── pages/                                # UI pages
    └── widgets/                              # Reusable widgets
```

---

## Key Contracts

### `Resident` Entity

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

### `ResidentRepository` (abstract)

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

---

## Manifest

Declared in `lib/manifest/manifest.dart`:

| Field                  | Value                                |
|------------------------|--------------------------------------|
| `name`                 | `"resident"`                         |
| `displayName`          | `"Resident Management"`              |
| `version`              | `1.0.0`                              |
| `description`          | Manage resident profiles, phone numbers, and email addresses |
| `minShellVersion`      | `1.0.0`                              |
| Permissions            | `resident.read`, `resident.write`, `resident.delete` |
| Dependencies           | `core_module ^1.0.0`                 |
| Feature Flags          | `resident.enabled`, `resident.visible`, `resident.export` |
| Provides               | `resident.crud`, `resident.search`   |

---

## Routes

```dart
/resident              → ResidentListPage
/resident/:id          → ResidentDetailPage
/resident/create       → ResidentCreatePage
```

Routes auto-register into the shell's GoRouter via `ModuleRegistry.allRoutes`.

---

## Dependencies

| Package           | Purpose                     |
|-------------------|-----------------------------|
| `core_module`     | Contracts, base classes     |
| `flutter_bloc`    | State management            |
| `go_router`       | Routing                     |
| `get_it`          | DI                          |
| `injectable`      | DI code generation          |
| `retrofit`        | API client generation       |
| `dio`             | HTTP client                 |
| `hive`            | Local storage               |

---

## How to Add a New Feature

1. **Entity** — add/update fields in `domain/entities/`
2. **Repository** — add methods to abstract repo, implement in `infrastructure/repositories/`
3. **Use Case** — create in `application/usecases/` using `UseCaseWithParams` or `UseCase`
4. **BLoC** — create in `presentation/bloc/`
5. **Page** — create in `presentation/pages/`, add route in `routes/resident_routes.dart`
6. **DI** — register new classes in `injection/resident_injection.dart`
