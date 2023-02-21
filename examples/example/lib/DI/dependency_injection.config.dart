// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../nav/app_state.dart' as _i3;
import '../retrofit_api_repo.dart' as _i5;
import 'register_module.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppState>(
    () => _i3.AppState(),
    dispose: _i3.disposeAppState,
  );
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio());
  gh.lazySingleton<_i5.Api>(() => _i5.Api(get<_i4.Dio>()));
  return get;
}

class _$RegisterModule extends _i6.RegisterModule {}
