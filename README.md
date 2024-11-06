# Store App with Clean Architecture and BLoC

A Flutter project implementing Clean Architecture principles and BLoC pattern for state management. The project features product management with data persistence using both SQLite and Hive.

> [!IMPORTANT]
> The purpose of this code is to use `dartz`,`freezed` , `injectable` ,in the program.

## Project Structure

The project follows Clean Architecture with the following layer structure:

```
lib/
  ├── core/
  │   ├── error/
  │   │   └── failures.dart
  │   └── usecases/
  │       └── usecase.dart
  ├── features/
  │   └── product/
  │       ├── domain/
  │       ├── data/
  │       └── presentation/
  └── injection.dart
```

### Core Dependencies

```yaml
dependencies:
  dartz: ^0.10.1
  flutter_bloc: ^8.1.6
  freezed_annotation: ^2.4.4
  get_it: ^8.0.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  injectable: ^2.5.0
  json_annotation: ^4.9.0
  json_serializable: ^6.8.0
  path: ^1.9.0
  path_provider: ^2.1.5
  sqflite: ^2.4.0

dev_dependencies:
  flutter_lints: ^5.0.0
  build_runner: ^2.4.13
  freezed: ^2.5.7
  hive_generator: ^2.0.1
  injectable_generator: ^2.6.2
```

## Architecture Layers

### 1. Domain Layer

This layer contains:

#### Entities
- `Product`: Core product model with fields:
  - id: Unique identifier
  - name: Product name
  - price: Product price
  - stock: Available quantity
  - categories: Product categories
  - createdAt: Creation timestamp

#### Repositories
- `ProductRepository`: Core interface for data operations with methods:
  - `getProducts`: Retrieve product list
  - `saveProduct`: Save new product

#### Use Cases
- `GetProducts`: Retrieve list of products
- `SaveProduct`: Save new product

### 2. Data Layer

#### Data Sources
- `ProductLocalDataSource`: Local data source with support for:
  - SQLite: Relational storage
  - Hive: Key-value storage

#### Repository Implementation
- `ProductRepositoryImpl`: Implementation of repository with error handling

### 3. Presentation Layer

#### BLoC
- `ProductBloc`: State management with events:
  - `fetchProducts`: Get products list
  - `addProduct`: Add new product

States:
- `initial`: Initial state
- `loading`: Loading state
- `loaded`: Data loaded state
- `error`: Error state

#### UI
- `ProductListPage`: Main page showing products list
- `ProductListItem`: Widget for displaying individual product

## Dependency Injection

Uses `get_it` and `injectable` for dependency injection:

- `DatabaseModule`: Database configurations
  - SQLite setup
  - Hive setup

## Implementation Details

### Error Handling
- Uses `Either` from `dartz` package for error handling
- Different `Failure` types for error categorization

### State Management
- Implements `flutter_bloc` for state management
- Separation of events and states using `freezed`

### Data Persistence
- Dual storage system using SQLite and Hive
- Caching capabilities

### Code Generation
Uses the following libraries for code generation:
- `freezed`: For data classes
- `injectable`: For dependency injection
- `hive_generator`: For Hive adapters

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run code generators:
```bash
flutter pub run build_runner build
```

3. Run the app:
```bash
flutter run
```

## Key Features

### Clean Architecture Implementation
- Clear separation of concerns
- Independent layers
- Testable code structure
- Domain-driven design

### State Management with BLoC
- Predictable state changes
- Separation of UI and business logic
- Easy testing
- Reactive programming approach

### Data Management
- Dual storage system
- Efficient caching
- Type-safe data handling
- Error handling at all layers

### Dependency Injection
- Service locator pattern
- Modular code structure
- Easy dependency management
- Auto-generated DI code

### Error Handling
- Comprehensive error types
- Functional programming approach
- Type-safe error handling
- User-friendly error messages

### Code Quality
- Type-safe programming with freezed
- Clean and maintainable code
- Following SOLID principles
- Extensive use of Flutter best practices

## Technical Considerations

### Database Schema
SQLite table structure for products:
```sql
CREATE TABLE products(
  id TEXT PRIMARY KEY,
  name TEXT,
  price REAL,
  stock INTEGER,
  categories TEXT,
  created_at TEXT
)
```

### State Flow
1. User triggers an action
2. BLoC receives an event
3. Use case is executed
4. Repository handles data operation
5. State is updated
6. UI reflects changes

### Performance Optimizations
- Efficient data caching
- Lazy loading when appropriate
- Minimal rebuilds in UI
- Optimized database queries

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.