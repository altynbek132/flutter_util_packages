# Utils Package

This is a utility package for Flutter and Dart projects. It provides a collection of helper functions and extensions that can be used to simplify your code and make it more efficient.

## Features

- **Dart Utilities**: Provides a set of utilites for Dart, such as List, Future, Dio, indexing, casting, mobx, String utilities.
- **Flutter Utilities**: Contains a set of utilites for Dart, such as animation, disposing, mobx, mobxWM utilites.

## Setup (**IMPORTANT**)

add to pubspec.yaml

```yaml
dependency_overrides:
  mobx:
    git:
      url: https://github.com/altynbek132/mobx.dart
      path: mobx
```

## Usage

To use this package, add it to your project's dependencies in your [`pubspec.yaml`] file and then import the relevant parts of the package in your Dart or Flutter files.

For example, to use the list utilities in a Dart file:

```dart
import 'package:utils/utils_dart.dart';

void main() {
  List<int> numbers = [1, 2];
  print(numbers.dup(2));  // prints [1, 1, 2, 2]
}
```

```dart
import 'package:utils/utils_flutter.dart';

void main() {
  MobxUtils.fromCN(ChangeNotifier());
}
```
