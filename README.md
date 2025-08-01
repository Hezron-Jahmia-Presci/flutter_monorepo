# Flutter Monorepo Workspace

This repository is a Flutter monorepo workspace using [Melos](https://melos.invertase.dev/) for managing multiple packages and apps.

## Structure

- `packages/` - Contains reusable Flutter packages (e.g. `responsive_layout`)
- `apps/` - Contains Flutter applications (e.g. `admin_dashboard`)

## Setup

### Prerequisites

- Flutter SDK installed (with Dart 3.8+)
- Melos installed globally (`dart pub global activate melos`)

### Install dependencies & link packages

```bash
melos bootstrap
```

This will run `flutter pub get` in all packages and apps and link local dependencies.

## Usage

- To run an app:

```bash
cd apps/admin_dashboard
flutter run
```

- To run Melos commands (e.g., run tests, format code across packages):

```bash
melos run test
melos run format
```

## Adding Packages or Apps

- Add new packages in `packages/` folder.
- Add new apps in `apps/` folder.
- Update `melos.yaml` and root `pubspec.yaml` if needed.

## Publishing Packages

- Publish your packages individually to pub.dev from their folders.
- Use `melos version` to bump versions consistently across packages.

---

## Resources

- Melos docs: https://melos.invertase.dev/
- Flutter docs: https://flutter.dev/docs

---

Made with ❤️ by Jahmia Hezron
