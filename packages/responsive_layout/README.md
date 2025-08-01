# responsive_layout

A Flutter package that provides a unified responsive layout widget to handle navigation and screen layout seamlessly across desktop and mobile platforms.  
It simplifies building adaptive apps by automatically switching between `NavigationRail` for desktop and `BottomNavigationBar` for mobile.

## Features

- Responsive navigation UI that adapts to screen size  
- Supports custom app bars and floating action buttons  
- Easy-to-use API with customizable navigation items and pages  
- Clean separation of mobile and desktop navigation patterns  
- Maintains internal navigation state automatically  
- Lightweight and Flutter-friendly

## Getting started

Before using this package, make sure you have Flutter SDK installed. This package supports Flutter apps targeting desktop and mobile platforms.

Add this package to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  responsive_layout:
    git:
      url: https://github.com/YOUR_USERNAME/YOUR_REPO.git
      path: packages/responsive_layout
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:responsive_layout/responsive_layout.dart';
```

Create a list of navigation items and corresponding pages:

```dart
final navItems = const [
  NavItem(
    filledIcon: Icons.home,
    unfilledIcon: Icons.home_outlined,
    label: 'Home',
  ),
  NavItem(
    filledIcon: Icons.settings,
    unfilledIcon: Icons.settings_outlined,
    label: 'Settings',
  ),
  NavItem(
    filledIcon: Icons.person,
    unfilledIcon: Icons.person_outline,
    label: 'Profile',
  ),
];

final pages = const [
  HomeScreen(),
  SettingsScreen(),
  ProfileScreen(),
];
```

Use the `Layout` widget as your main scaffold wrapper:

```dart
Layout(
  appBar: AppBar(title: const Text('My App')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
  navItems: navItems,
  pages: pages,
);
```

The widget will automatically switch between desktop and mobile navigation UI based on screen width.

## Additional information

- Contributions, issues, and feature requests are welcome! Please open a GitHub issue or pull request.  
- For more detailed examples, see the `/example` folder.  
- This package is maintained by [Your Name](https://github.com/YOUR_USERNAME).  

---

Made with ❤️ using Flutter  
