# Modular Architecture Rules

# Flutter Modular Architecture

## Purpose

This project uses a modular multi-repository Flutter architecture.

Goals:

* domain isolation
* independent development
* independent release
* reusability
* scalability

---

# Architecture

Applications compose modules.

Business modules own domains.

Core modules provide shared capabilities.

Allowed:

Application
→ Module

Module
→ Core Module

Forbidden:

Business Module
→ Business Module

Examples:

Forum Module
→ Resident Module

Maps Module
→ Resident Module

Appointment Module
→ Forum Module

---

# Ownership

Each domain must have exactly one owner.

Only the owner module may define:

* entities
* business rules
* use cases
* repository contracts

Examples:

Resident Module

* Resident
* Household
* Occupancy
* ResidentAddress

Finance Module

* Bill
* Payment
* Ledger
* Transaction

Forum Module

* Post
* Comment
* Reply
* Reaction

Maps Module

* HouseCoordinate
* FacilityLocation
* MapLayer

Appointment Module

* Appointment
* Schedule
* Reservation

Do not duplicate ownership.

If a domain already exists, extend the owner module.

---

# Standard Structure

```text
module_name/

lib/
├── public_api.dart
├── module.dart
└── src/
    ├── domain/
    ├── data/
    ├── presentation/
    └── routes/
```

Modules own:

* entities
* use cases
* repository contracts
* presentation
* routes
* state management

Applications own:

* dependency injection
* route composition
* environment configuration
* analytics
* authentication bootstrap

---

# Dependency Injection

Modules depend on abstractions only.

Allowed:

```dart
abstract class ResidentRepository {}
```

Forbidden:

```dart
final dio = Dio();

FirebaseFirestore.instance

Supabase.instance.client
```

Infrastructure must be injected by the application.

Applications own:

* Dio
* Firebase
* Supabase
* Secure Storage
* Shared Preferences
* Analytics

---

# Routing

Modules define routes.

Applications compose routes.

Example:

```dart
GoRouter(
  routes: [
    ...ResidentModule.routes(),
    ...ForumModule.routes(),
    ...MapsModule.routes(),
  ],
);
```

Modules must not register themselves globally.

---

# Repository Rules

Allowed:

Forum Module
→ ForumRepository

Resident Module
→ ResidentRepository

Maps Module
→ MapsRepository

Forbidden:

Forum Module
→ ResidentRepository

Maps Module
→ ResidentRepository

Finance Module
→ ForumRepository

Modules must never directly access repositories owned by another module.

---

# Communication

Cross-module communication must happen through:

* contracts
* public APIs
* dependency injection
* application composition

Forbidden:

* direct repository access
* internal source imports
* module instantiation
* business logic sharing

---

# Public API

Consumers may only use:

```dart
import 'package:module/public_api.dart';
```

Forbidden:

```dart
import 'package:module/src/...';
```

Internal implementation must remain private.

---

# Native Services

Reusable capabilities may live inside modules:

* share
* camera
* file picker
* biometric
* permissions

Application-specific integrations belong to applications:

* API keys
* Firebase projects
* analytics configuration
* deep links
* environment configuration

---

# Validation

Before implementation:

1. Identify owner module.
2. Verify ownership is unique.
3. Verify dependency direction.
4. Verify repository boundaries.
5. Verify public API usage.
6. Verify application remains composition root.

Reject:

* duplicated ownership
* module-to-module dependencies
* repository sharing
* domain leakage
* direct infrastructure usage

STATUS: NEEDS\_REVISION

# Module Boundary Rules

## Purpose

Define ownership boundaries between modules.

Prevent:

* domain leakage
* circular dependencies
* repository sharing
* duplicated business logic
* cross-module implementation coupling

Every business concept must have exactly one owner module.

---

# Ownership Principles

A module owns its domain.

Only the owner module may:

* define entities
* define business rules
* define use cases
* define repository contracts
* modify domain behavior

Other modules are consumers only.

---

# Domain Ownership

## Resident Module

Owns:

* Resident
* Household
* Occupancy
* ResidentProfile
* ResidentAddress

Responsibilities:

* resident management
* household management
* occupancy management

---

## Finance Module

Owns:

* Bill
* Payment
* Ledger
* Transaction
* FinancialReport

Responsibilities:

* billing
* payment processing
* accounting records

---

## Forum Module

Owns:

* Post
* Comment
* Reply
* Reaction
* ReportedContent

Responsibilities:

* community discussions
* complaints
* aspirations
* community engagement

---

## Maps Module

Owns:

* HouseCoordinate
* FacilityLocation
* MapMarker
* MapLayer

Responsibilities:

* geolocation
* mapping
* facilities visualization

---

## Appointment Module

Owns:

* Appointment
* Schedule
* Reservation
* Availability

Responsibilities:

* scheduling
* booking
* appointment management

---

# Ownership Validation

Before implementing any feature:

Determine:

1. Which module owns the domain.
2. Which module consumes the domain.
3. Whether ownership already exists.

Reject:

* duplicated ownership
* shared ownership
* unclear ownership

---

# Dependency Rules

Allowed:

Business Module
→ Core Module

Application
→ Business Module

Application
→ Core Module

---

Forbidden:

Forum Module
→ Resident Module

Maps Module
→ Resident Module

Appointment Module
→ Forum Module

Finance Module
→ Maps Module

Business Module
→ Business Module

---

# Repository Access Rules

Allowed:

Module
→ Own Repository

Example:

Forum Module
→ ForumRepository

Resident Module
→ ResidentRepository

---

Forbidden:

Forum Module
→ ResidentRepository

Maps Module
→ ResidentRepository

Finance Module
→ ForumRepository

Appointment Module
→ FinanceRepository

Modules must never directly access repositories owned by another module.

---

# Data Access Rules

When a module requires information from another domain:

Do not access repositories directly.

Do not import implementation classes.

Use:

* contracts
* public APIs
* dependency injection
* application composition

---

# Cross Module Communication

Allowed:

Application
→ inject dependency
→ module

Application
→ aggregate data
→ module

Application
→ compose workflows
→ module

---

Forbidden:

Module
→ query another module

Module
→ instantiate another module

Module
→ import another module internal implementation

---

# Public API Boundary

Consumers may only use:

public\_api.dart

Allowed:

import package:forum\_module/public\_api.dart

Forbidden:

import package:forum\_module/src/\*
import package:resident\_module/src/\*
import package:maps\_module/src/\*

Internal implementation must remain private.

---

# Validation Checklist

Before approving any implementation verify:

* ownership is clearly defined
* only one module owns the domain
* no business module depends on another business module
* repositories are not shared
* cross-module communication uses contracts
* only public APIs are consumed
* application remains the composition root

If any validation fails:

STATUS: NEEDS\_REVISION

# Flutter Modular Architecture Skill

## Purpose

This project uses a modular multi-repository Flutter architecture.

Every business feature must be developed as an independent Flutter package/module that can be consumed by one or more applications.

The objective is:

* domain isolation
* independent development
* independent release
* reusability
* scalability

---

# Core Principles

A module owns a business domain.

Examples:

* resident\_module
* finance\_module
* forum\_module
* maps\_module
* appointment\_module

A module must be independently maintainable.

A module must never directly depend on another business module.

---

# Dependency Rules

Allowed:

```text
module
  ↓
core_module
```

Allowed:

```text
rt_rw_app
  ↓
resident_module

rt_rw_app
  ↓
forum_module
```

Forbidden:

```text
forum_module
  ↓
resident_module
```

Forbidden:

```text
maps_module
  ↓
resident_module
```

Forbidden:

```text
appointment_module
  ↓
forum_module
```

The application is responsible for connecting modules together.

---

# Module Ownership

Each module owns:

* domain entities
* use cases
* repository contracts
* presentation layer
* route definitions
* state management

A module must not own:

* global configuration
* application branding
* application routing composition
* API credentials
* environment configuration

These belong to the application layer.

---

# Standard Module Structure

```text
module_name/

├── lib/
│
├── public_api.dart
│
├── module.dart
│
└── src/
    │
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    │
    ├── data/
    │   ├── datasource/
    │   ├── dto/
    │   └── repositories/
    │
    ├── presentation/
    │   ├── pages/
    │   ├── widgets/
    │   └── bloc/
    │
    ├── routes/
    │
    └── di/
```

---

# Public API Rules

Consumers may only import:

```dart
import 'package:module_name/public_api.dart';
```

Forbidden:

```dart
import 'package:module_name/src/...';
```

Internal implementation must remain private.

---

# Routing Rules

Each module owns its own route definitions.

Example:

```dart
class ResidentModule {
  static List<RouteBase> routes() {
    return ResidentRoutes.routes;
  }
}
```

Application composes routes.

Example:

```dart
GoRouter(
  routes: [
    ...ResidentModule.routes(),
    ...ForumModule.routes(),
    ...MapsModule.routes(),
  ],
);
```

Modules must not directly register themselves into the application's router.

---

# Dependency Injection Rules

Modules must depend on abstractions only.

Allowed:

```dart
abstract class ResidentRepository {}
```

Forbidden:

```dart
final dio = Dio();
```

Forbidden:

```dart
FirebaseFirestore.instance
```

Forbidden:

```dart
Supabase.instance.client
```

Infrastructure dependencies must be injected by the application.

---

# Repository Rules

Modules define contracts.

Example:

```dart
abstract class ResidentRepository {
  Future<List<Resident>> getResidents();
}
```

Applications provide implementations.

Example:

```dart
class ResidentApiRepository
    implements ResidentRepository {}
```

---

# Native Platform Rules

Reusable platform capabilities may exist inside modules:

* share
* camera
* file picker
* biometric
* permissions

Application-specific integrations must remain in the application layer:

* API keys
* Firebase projects
* Analytics configuration
* Deep link schemes
* Environment configuration

---

# Application Responsibilities

Applications act as composition roots.

Applications are responsible for:

* dependency injection
* module wiring
* configuration
* environment setup
* authentication bootstrap
* route composition

Applications must not contain business logic that belongs to modules.

---

# Validation Checklist

Before creating or modifying a module verify:

* module owns a single business domain
* module does not depend on another business module
* module exposes a public API
* module owns its presentation layer
* module defines repository contracts
* infrastructure is injected
* routing is self-contained
* application remains the composition root

If any rule is violated:

STATUS: NEEDS\_REVISION

```

```

Each module must be independently releasable.

Modules must not depend on other business modules.

Allowed:

forum_module
-> core_module

maps_module
-> core_module

resident_module
-> core_module

Forbidden:

forum_module
-> resident_module

maps_module
-> resident_module

appointment_module
-> forum_module

Communication between modules must happen through:

- Contracts
- Public APIs
- Composition Root

The application layer is responsible for wiring modules together.
