# gowagr_mobile_assessment

A new Flutter project.

## Getting Started

# Flutter Project Architecture Overview

This project follows a scalable and testable architecture using the following tools:

- ✅ **State Management**: [Provider](https://pub.dev/packages/provider)
- ✅ **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- ✅ **Network Layer**: Dio-based API client
- ✅ **Local Cache**: SQLite-backed generic cache service

---

## 🏗️ Project Structure

```plaintext
lib/
├── core/
│   ├── base/                    # Contains the base classes for ViewModel, Views
│   ├── services/                # Network service, CacheService interface & SQLite implementation
│   └── models/                  # Contains the shared model used in API response
│   └── dependency_injection/    # Dependency Injection setup (get_it)
├── features/
│   └── explore/
│       ├── data/
│       │   ├── datasource/      # RemoteDataSource abstraction and implementation
│       │   ├── local/           # Caching with sqlite interface
│       │   └── repository/      # Optional: abstraction layer for business logic
│       ├── domain/
│       │   └── models/          # Business entities or domain-level models
│       └── presentation/
│           ├── view_models/     # State management using Provider
│           └── screens/         # UI widgets
│           └── widgets/         # Shared widget used within the presentation screen
├── helpers/                     # contain helper methods for date formatting, paginated list view
└── main.dart
```

---

## 🧠 Dependency Injection (GetIt)

```dart
final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(() => DioApiClient('https://api.example.com'));

  // Remote data source
  getIt.registerLazySingleton<RemoteDataSource<User>>(
    () => RemoteDataSourceImpl<User>(
      client: getIt<DioApiClient>(),
      endpoint: '/users',
      fromJson: (json) => User.fromJson(json),
      toJson: (user) => user.toJson(),
    ),
  );

  // Cache registry
  CacheRegistry.register<User>(
    tableName: 'user_cache',
    fromJson: (json) => User.fromJson(json),
    toJson: (user) => user.toJson(),
  );

  getIt.registerLazySingleton<CacheService<User>>(() => CacheServiceImpl<User>());
}
```

---

## 💾 Caching (SQLite)

Generic SQLite-based caching system:

- Supports any data model with fromJson/toJson
- Handles basic CRUD operations

```dart
final cache = getIt<CacheService<User>>();
await cache.save('user_1', user);
final cachedUser = await cache.read('user_1');
```

---

## 📡 Remote Data Source (Dio)

Abstracted data source:

```dart
final users = await getIt<RemoteDataSource<User>>().fetchAll();
final user = await getIt<RemoteDataSource<User>>().fetchById('123');
```

Supports paginated APIs:

```dart
final paginated = await getIt<RemoteDataSource<User>>().fetchPaginated(query: {'page': 1});
```

---

## 🔄 State Management (Provider)

```dart
class UserProvider extends ChangeNotifier {
  final RemoteDataSource<User> _remote = getIt<RemoteDataSource<User>>();
  final CacheService<User> _cache = getIt<CacheService<User>>();

  User? _user;
  bool _loading = false;

  User? get user => _user;
  bool get isLoading => _loading;

  Future<void> loadUser(String id) async {
    _loading = true;
    notifyListeners();

    _user = await _remote.fetchById(id);
    await _cache.save(id, _user!);

    _loading = false;
    notifyListeners();
  }
}
```

Register it in your widget tree:

```dart
ChangeNotifierProvider(
  create: (_) => UserProvider(),
  child: MyApp(),
)
```

---

## ✅ Dependencies

```yaml
dependencies:
  flutter:
  dio:
  provider:
  get_it:
  sqflite:
  path_provider:
  path:
  json_annotation:
  cached_network_image:

dev_dependencies:
  build_runner:
  freezed:
  json_serializable:
```

---

## 📎 Summary

| Concern              | Tool Used        |
|----------------------|------------------|
| State Management     | `provider`       |
| Dependency Injection | `get_it`         |
| Networking           | `dio`            |
| Caching              | `sqflite`        |

This setup ensures modular, testable, and production-ready Flutter architecture.


💡 Tip: Don't forget to run flutter pub run build_runner build on every pull.