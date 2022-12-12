import 'package:rxdart/rxdart.dart';

Future<void> main() async {
  final s = BehaviorSubject<int>();

  final ss = s.stream.skipError;
  ss.listen((value) => print('value: ${value}'));

  s.add(1);
  s.addError(Exception('error'));
  s.add(2);
  s.add(3);
  s.add(4);
}

extension StreamExtension<T> on Stream<T> {
  Stream<T> get skipError => handleError((e, st) {});
}
