import 'dart:collection';

Future<void> main() async {
  print(identityHashCode('asdf'));
  print(identityHashCode('as' + 'df'));
}
