import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() => $initGetIt(locator);

void initLazySingletons() {}

extension GetItExtension on GetIt {
  T? getMaybeNull<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    if (isRegistered<T>(instanceName: instanceName)) {
      return get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );
    }
    return null;
  }
}
