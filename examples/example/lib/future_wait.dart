import 'package:utils/src/utils.dart';

Future<void> main() async {
  futureWait([
    await Future.delayed(const Duration(milliseconds: 100)),
    Future.sync(() => 1),
  ]);
}
