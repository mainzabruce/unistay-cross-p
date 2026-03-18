# UniStay - Production-Grade Flutter Hostel Booking Application

## Project Overview

UniStay is a cross-platform mobile application for booking hostel accommodations, built with Flutter and Dart following clean architecture principles.

## Architecture

### Clean Architecture Layers

```
lib/
├── core/                    # Core utilities and shared components
│   ├── constants/           # App-wide constants (colors, spacing, etc.)
│   ├── errors/              # Error handling (failures, exceptions)
│   ├── network/             # Network configuration and interceptors
│   ├── theme/               # Theme configuration and text styles
│   ├── usecases/            # Base use case classes
│   └── utils/               # Utility functions and extensions
├── features/                # Feature modules
│   ├── auth/                # Authentication feature
│   │   ├── data/            # Data layer (models, repositories, datasources)
│   │   ├── presentation/    # UI layer (screens, widgets)
│   │   └── providers/       # State management (Riverpod)
│   ├── home/                # Home screen feature
│   ├── search/              # Search functionality
│   ├── details/             # Hostel details screen
│   ├── booking/             # Booking flow
│   └── profile/             # User profile and settings
└── shared/                  # Shared components across features
    └── widgets/             # Reusable widgets
```

## Design System

### Colors
- **Primary**: `#3A7D44` (Green - trust and growth)
- **Secondary**: `#FFD166` (Yellow - warmth)
- **Background**: `#F8F9FA`
- **Surface**: `#FFFFFF`
- **Error**: `#EF476F`
- **Success**: `#06D6A0`

### Typography (Inter Font Family)
- Heading1: 28px SemiBold
- Heading2: 24px SemiBold
- Heading3: 20px Medium
- Body: 16px Regular
- Caption: 14px Regular
- Button: 16px Medium (uppercase)

### Spacing Scale
4px / 8px / 16px / 24px / 32px

### Components
- Buttons: 44px height, fully rounded
- Cards: 8px radius, 2px elevation, 16px padding
- Inputs: Outlined, 12px padding, 8px radius

## Tech Stack

### State Management
- **Riverpod** - Reactive state management with compile-time safety

### Navigation
- Custom route generator with PageRouteBuilder animations

### Networking
- **Dio** - HTTP client with interceptors

### Local Storage
- **SharedPreferences** - Simple key-value storage

### Image Handling
- **Cached Network Image** - Image caching and memory optimization

### Utilities
- **Equatable** - Value equality for models
- **Dartz** - Functional programming (Either type)

## Key Features Implemented

### Authentication
- Email/password login screen with validation
- User registration flow
- Password reset navigation
- Persistent sessions via local storage

### Home Screen
- Featured hostels with vertical list
- Horizontal carousel for "Near You" section
- Category filtering chips
- Location selector
- Search bar integration
- Bottom navigation with Material 3 NavigationBar

### Search
- Debounced search input
- Filter chips for amenities
- Sort controls ready
- Results list with compact cards
- Empty state handling

### Hostel Details
- Image carousel with page indicators
- Rating display with review count
- Amenities section with chips
- Reviews section
- Sticky booking CTA at bottom

### Booking Flow
- Date picker for check-in/check-out
- Guest counter with increment/decrement
- Payment method selection
- Booking summary with price breakdown
- Loading states

### Profile
- User avatar with initials
- Menu items for settings
- Booking history preview
- Logout confirmation dialog

## Performance Optimizations Applied

1. **Image Caching**: CachedNetworkImage for all remote images with placeholders
2. **Lazy Loading**: ListView.builder for efficient list rendering
3. **Const Constructors**: All stateless widgets use const where possible
4. **Provider AutoDispose**: Ready for Riverpod autoDispose modifiers
5. **Efficient Rebuilds**: Selective widget rebuilding patterns
6. **Memory Management**: Proper controller disposal in dispose() methods
7. **Sliver Lists**: CustomScrollView with SliverList for scroll performance

## Responsive Design

- SafeArea handling for notches and system UI
- Flexible layouts with Expanded and Flexible widgets
- Text scaling support through TextStyle inheritance
- Adaptive spacing using AppSpacing constants
- Tablet-ready breakpoints in place

## File Structure Summary

```
lib/
├── main.dart                        # App entry point
├── app.dart                         # Main app widget & routes
├── core/
│   ├── constants/app_constants.dart # Colors, spacing, dimensions
│   ├── errors/
│   │   ├── failures.dart            # Failure types for Either
│   │   └── exceptions.dart          # Exception classes
│   ├── network/network_config.dart  # Dio setup & interceptors
│   ├── theme/
│   │   ├── app_theme.dart           # ThemeData configuration
│   │   └── app_text_styles.dart     # Typography system
│   ├── usecases/usecase.dart        # Base use case pattern
│   └── utils/
│       ├── extensions.dart          # Dart extensions
│       └── logger.dart              # Debug logging
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/local_auth_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_entity.dart
│   │   │   └── repositories/
│   │   │       ├── auth_repository.dart
│   │   │       └── auth_repository_impl.dart
│   │   ├── presentation/screens/login_screen.dart
│   │   └── providers/auth_provider.dart
│   ├── home/
│   │   ├── data/models/hostel_model.dart
│   │   └── presentation/screens/home_screen.dart
│   ├── search/presentation/screens/search_screen.dart
│   ├── details/presentation/screens/hostel_details_screen.dart
│   ├── booking/presentation/screens/booking_screen.dart
│   └── profile/presentation/screens/profile_screen.dart
└── shared/widgets/common_widgets.dart # AppButton, AppCard, etc.
```

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+

### Installation

```bash
# Install dependencies
flutter pub get

# Run code generation (for json_serializable, freezed, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Configuration

Update the API base URL in `lib/core/network/network_config.dart`:

```dart
static const String baseUrl = 'https://your-api-endpoint.com';
```

## Code Quality Standards

- ✅ Null safety everywhere
- ✅ Latest Flutter stable conventions
- ✅ Clean architecture separation
- ✅ Reusable widgets
- ✅ Production-ready error handling
- ✅ Consistent design system
- ✅ Performance optimizations
- ✅ Responsive layouts

## Next Steps for Production

1. Connect to real backend API
2. Implement Firebase Auth or custom JWT auth
3. Add comprehensive unit and widget tests
4. Set up CI/CD pipeline
5. Configure app flavors (dev, staging, prod)
6. Add analytics and crash reporting
7. Implement push notifications
8. Add offline mode with Hive
9. Integrate maps for location display
10. Add multi-language support

## License

Copyright © 2024 UniStay. All rights reserved.
