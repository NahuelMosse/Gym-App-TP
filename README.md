# 🏋️ Gym App

A Flutter application for gym workout tracking and routine planning

## 📋 Table of Contents

- [🚀 Installation & Setup](#-installation--setup)
- [▶️ Running the Project](#-running-the-project)
- [🏗️ Architecture](#-architecture)
- [📁 Project Structure](#-project-structure)
- [🔍 Component Definitions](#-component-definitions)
- [💡 Practical Example](#-practical-example-user-login-flow)
- [🛠️ Useful Commands](#-useful-commands)
- [🌐 Internationalization (i18n)](#-internationalization-i18n)
- [🤝 Contributing](#-contributing)

---

## 🚀 Installation & Setup

### Prerequisites

- **Flutter SDK**: 3.9.2 or higher
- **Dart**: Included with Flutter SDK
- **Git**: To clone the repository

### 1. Clone Repository

```bash
git clone https://github.com/NahuelMosse/Gym-App.git
cd Gym-App
```

### 2. Environment Configuration

#### For Flutter App:

```bash
# In gym_app/ folder
cp .env.example .env
cp .env.example .env.prod
cp .env.example .env.qa
```

Edit the `.env` file:
```bash
# API Configuration
API_URL=http://10.0.2.2:8080

# HTTP request timeout in seconds
HTTP_TIMEOUT=30
```

### 3. Install Dependencies

#### Flutter App:
```bash
cd gym_app
flutter pub get
```

## ▶️ Running the Project

### Option 1: Step by Step

#### 1. Run Flutter App
```bash
cd gym_app
flutter run
```

### Option 2: VS Code Development

1. Open the project root folder in VS Code
2. Use `F5` or debug button to run the Flutter app

---

## 🏗️ Architecture

The project follows **Clean Architecture** with the following structure:

```
📦 gym_app/
├── 🎯 Domain Layer (Business Rules)
│   ├── entities/     # Domain entities
│   ├── repositories/ # Repository contracts
│   └── usecases/     # Use cases
├── 📊 Data Layer (Data Sources)
│   ├── datasources/  # Local and Remote data sources
│   ├── models/       # Data models
│   └── repositories/ # Repository implementations
└── 🎨 Presentation Layer (UI)
    ├── pages/        # App pages
    ├── widgets/      # Reusable widgets
    └── state/        # BLoC/Cubit for state management
```

---

## 📁 Project Structure

```
gym_app/
├── lib/
│   ├── core/                           # 🔧 Shared Infrastructure
│   │   ├── shared/                     # 📋 Common Configuration
│   │   │   ├── app_config.dart         # Environment settings (API URLs, timeouts)
│   │   │   └── storage_keys.dart       # Secure storage and SharedPreferences keys
│   │   ├── entities/                   # 🎯 Domain Core Entities
│   │   ├── errors/                     # ⚠️ Error Management System
│   │   │   └── exceptions.dart         # Custom exceptions hierarchy (Network, Auth, etc.)
│   │   ├── interfaces/                 # 📝 Base Contracts
│   │   │   └── base_interfaces.dart    # Repository, DataSource, UseCase base interfaces
│   │   ├── network/                    # 🌐 HTTP Infrastructure
│   │   │   └── token_interceptor.dart  # JWT token management for API calls
│   │   ├── presentation/               # 🎨 Shared UI Components
│   │   │   ├── pages/                  # Common pages (Home, Loading)
│   │   │   └── widgets/                # Reusable UI widgets
│   │   └── core_injection.dart         # Core dependency injection setup
│   │
│   ├── features/                       # 🏗️ Feature Modules
│   │   └── feature_name/               # � Generic Feature Structure
│   │       ├── data/                   # 💾 Data Layer Implementation
│   │       │   ├── datasources/        # Data source implementations
│   │       │   ├── models/             # Data models with JSON serialization
│   │       │   └── repositories/       # Repository implementations
│   │       ├── domain/                 # 🎯 Business Logic Layer
│   │       │   ├── entities/           # Pure business objects
│   │       │   ├── repositories/       # Repository contracts
│   │       │   └── usecases/           # Business use cases
│   │       ├── presentation/           # 🎨 UI Layer
│   │       │   ├── pages/              # Feature screens
│   │       │   ├── widgets/            # Feature-specific widgets
│   │       │   ├── state/              # State management (BLoC/Cubit)
│   │       │   └── utils/              # Presentation utilities
│   │       └── feature_injection.dart  # Feature dependency injection
│   │
│   ├── injection_container.dart        # 🔗 Global DI Container
│   ├── app.dart                        # 📱 App Widget Configuration
│   └── main.dart                       # 🚀 Application Entry Point
│
├── android/                            # 🤖 Android Platform Code
├── ios/                                # 🍎 iOS Platform Code
├── linux/                              # 🐧 Linux Platform Code
├── macos/                              # 💻 macOS Platform Code
├── web/                                # 🌐 Web Platform Code
├── windows/                            # � Windows Platform Code
├── build/                              # � Build Artifacts
├── pubspec.yaml                        # 📦 Dependencies & Assets
├── pubspec.lock                        # 🔒 Dependency Lock File
├── analysis_options.yaml               # 📊 Dart Analysis Configuration
├── .env.example                        # 🔧 Environment Template
├── .env                                # 🔐 Development Environment (local)
├── .env.prod                           # 🏭 Production Environment
├── .env.qa                             # 🧪 QA Environment
├── .gitignore                          # 📋 Git Ignore Rules
└── README.md                           # 📖 Project Documentation
```

### 🔍 Detailed Responsibilities

#### 🔧 **Core Layer**
- **Purpose**: Shared infrastructure and utilities used across all features
- **Dependencies**: Can only depend on external packages, never on features
- **Examples**: HTTP client setup, error handling, base interfaces

#### 🎯 **Domain Layer** (per feature)
- **Purpose**: Pure business logic without external dependencies
- **Rules**: No Flutter/UI imports, no external API calls
- **Contains**: Entities, Use Cases, Repository interfaces
- **Example**: `LoginUseCase` contains login validation logic

#### 💾 **Data Layer** (per feature)
- **Purpose**: Handle data sources and implement domain repositories
- **Responsibilities**: API calls, local storage, data transformation
- **Flow**: `Repository Impl` → `DataSources` → `Models` ↔ `External APIs/DB`

#### 🎨 **Presentation Layer** (per feature)
- **Purpose**: UI components and state management
- **Contains**: Pages, Widgets, BLoC/Cubit, Navigation logic
- **Rule**: Only this layer can import Flutter/UI packages

#### 🔗 **Dependency Injection**
- **Global**: `injection_container.dart` - coordinates all feature DI
- **Core**: `core_injection.dart` - shared services (HTTP, storage)
- **Feature**: `*_injection.dart` - feature-specific dependencies

---

## 🔍 Component Definitions

### 📊 **DataSource**
**What it does**: Direct interface with external data sources (APIs, databases, local storage)
- **Local DataSource**: Handles local storage (SQLite, SharedPreferences, SecureStorage)
- **Remote DataSource**: Manages HTTP requests, API calls, and network operations
- **Responsibilities**: Raw data operations, serialization/deserialization, connection management
- **Example**: `getUserFromApi()`, `saveUserToCache()`, `deleteUserFromStorage()`

### 🏛️ **Repository**
**What it does**: Coordinates between data sources and provides clean data to the domain layer
- **Acts as**: Single source of truth, data orchestrator, business rule enforcer
- **Responsibilities**: Decide data source priority, handle offline scenarios, data validation
- **Example**: Try cache first, then API; merge local and remote data; handle data synchronization

### 🎯 **UseCase**
**What it does**: Contains specific business logic and orchestrates domain operations
- **Single responsibility**: Each use case handles one specific business operation
- **Pure business logic**: No UI dependencies, no external framework dependencies
- **Responsibilities**: Input validation, business rule execution, output formatting
- **Example**: `LoginUseCase` validates credentials and returns success/failure with specific business rules

### 🎨 **State Management (BLoC/Cubit)**
**What it does**: Manages UI state and coordinates between presentation and domain layers
- **State holder**: Maintains current UI state (loading, success, error, data)
- **Event processor**: Handles user interactions and triggers appropriate use cases
- **UI coordinator**: Provides reactive state updates to widgets
- **Example**: User taps login → BLoC calls LoginUseCase → Updates UI state based on result

---

## 💡 Practical Example: User Login Flow

Let's trace through a complete user login operation across all layers:

### 🎯 **1. Domain Layer** (Business Rules)

```dart
// entities/user.dart
class User {
  final String id;
  final String email;
  final String name;
  
  User({required this.id, required this.email, required this.name});
}

// repositories/auth_repository.dart (Contract)
abstract class AuthRepository {
  Future<User> login(String email, String password);
}

// usecases/login_usecase.dart
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<User> call(String email, String password) async {
    // Business rule: validate email format
    if (!email.contains('@')) throw InvalidEmailException();
    
    // Business rule: password minimum length
    if (password.length < 6) throw WeakPasswordException();
    
    return await repository.login(email, password);
  }
}
```

### 📊 **2. Data Layer** (Data Sources & Repository Implementation)

```dart
// datasources/remote_auth_datasource.dart
class RemoteAuthDataSource {
  Future<UserModel> login(String email, String password) async {
    final response = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }
}

// datasources/local_auth_datasource.dart  
class LocalAuthDataSource {
  Future<void> saveUser(UserModel user) async {
    await secureStorage.write(key: 'user', value: jsonEncode(user.toJson()));
  }
  
  Future<UserModel?> getStoredUser() async {
    final userData = await secureStorage.read(key: 'user');
    return userData != null ? UserModel.fromJson(jsonDecode(userData)) : null;
  }
}

// repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final LocalAuthDataSource localDataSource;
  
  @override
  Future<User> login(String email, String password) async {
    try {
      // Try remote first
      final userModel = await remoteDataSource.login(email, password);
      
      // Save to local for offline access
      await localDataSource.saveUser(userModel);
      
      // Convert model to entity
      return userModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
```

### 🎨 **3. Presentation Layer** (State Management & UI)

```dart
// state/auth_event.dart
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

// state/auth_state.dart
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// state/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  
  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  
  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

// pages/login_page.dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthLoading:
            return CircularProgressIndicator();
          case AuthSuccess:
            return HomePage(user: state.user);
          case AuthFailure:
            return Text('Error: ${state.message}');
          default:
            return LoginForm(
              onLogin: (email, password) {
                context.read<AuthBloc>().add(LoginRequested(email, password));
              },
            );
        }
      },
    );
  }
}
```

### 🔄 **Complete Flow Summary**:

1. **User Input** → `LoginPage` collects email/password
2. **Event Trigger** → `AuthBloc` receives `LoginRequested` event  
3. **Business Logic** → `LoginUseCase` validates and processes request
4. **Data Coordination** → `AuthRepository` coordinates between remote/local sources
5. **Data Fetching** → `RemoteDataSource` makes API call, `LocalDataSource` caches result
6. **State Update** → `AuthBloc` emits new state based on result
7. **UI Reaction** → `LoginPage` rebuilds UI based on new state

This flow demonstrates how each layer has a single responsibility and how data flows unidirectionally through the architecture while maintaining separation of concerns.

---

## 🛠️ Useful Commands

### Flutter
```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Build for production
flutter build apk --release

# Clean project
flutter clean && flutter pub get
```

## 🌐 Internationalization (i18n)

This app supports multiple languages using Flutter's official internationalization system.

### Supported Languages
- 🇺🇸 **English** (en) - Default
- 🇪🇸 **Spanish** (es)

### Adding New Languages

1. **Create new ARB file**:
   ```bash
   # Create lib/features/internationalization/translations/[locale].arb
   # Example: lib/features/internationalization/translations/fr.arb for French
   ```

2. **Add translations**:
   ```json
   {
     "@@locale": "fr",
     "appName": "Gym App",
     "signInToContinue": "Connectez-vous pour continuer",
     // ... add all required keys
   }
   ```

3. **Generate localization files**:
   ```bash
   flutter gen-l10n
   ```

### Using Translations in Code

```dart
@override
Widget build(BuildContext context) {
  final translations = Translations.of(context);
  
  return Text(translations.welcomeToGymApp);
}
```

### Language Configuration Files

- **ARB Files** (EDITABLE): `lib/features/internationalization/translations/*.arb` - Translation definitions
- **Generated Files** (DO NOT EDIT): `lib/features/internationalization/generated/` - Auto-generated classes
  - `translations.dart` - Main class (import this)
  - `_en.dart`, `_es.dart` - Internal implementations (do not import)
- **Configuration**: `l10n.yaml` - Generation settings

### How Language Selection Works

The app automatically detects the device's system language and uses the appropriate translations. If the device language is not supported, it falls back to English.

Users can manually change the language using the language picker in the app bar (🌐 icon).

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
