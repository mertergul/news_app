# News App

A Flutter application that displays news posts using a clean architecture approach.

## Features

- View list of news posts
- Error handling with retry functionality
- Loading states
- Clean Architecture implementation
- BLoC pattern for state management
- Unit, Widget, and Integration tests

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Presentation Layer**: Contains UI components, BLoC, and widgets
- **Domain Layer**: Contains business logic and entities
- **Data Layer**: Contains repositories and data sources

## Project Structure

```
lib/
├── app/
│   ├── core/
│   │   ├── constants/
│   │   ├── di/
│   │   └── network/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   └── repositories/
│   └── presentation/
│       ├── features/
│       │   └── home/
│       └── widgets/
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code


## Testing

The project includes three types of tests:

## Dependencies

- **flutter_bloc**: ^8.1.3 - State management
- **dio**: ^5.4.0 - HTTP client
- **get_it**: ^7.6.4 - Dependency injection
- **equatable**: ^2.0.5 - Value equality
- **flutter_dotenv**: ^5.1.0 - Environment variables
- **firebase_core**: ^2.24.2 - Firebase integration
- **firebase_messaging**: ^14.7.10 - Push notifications
- **flutter_local_notifications**: ^16.3.0 - Local notifications


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
