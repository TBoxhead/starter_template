// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:starter_template/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i6;
import 'package:starter_template/domain/auth/i_auth_facade.dart' as _i4;
import 'package:starter_template/infrastructure/auth/local_auth_facade.dart'
    as _i5;
import 'package:starter_template/infrastructure/core/local_injectable_module.dart'
    as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    gh.factoryAsync<_i3.SharedPreferences>(() => registerModules.prefs);
    gh.factoryAsync<_i4.IAuthFacade>(() async =>
        _i5.LocalAuthFacade(await getAsync<_i3.SharedPreferences>()));
    gh.factoryAsync<_i6.SignInFormBloc>(
        () async => _i6.SignInFormBloc(await getAsync<_i4.IAuthFacade>()));
    return this;
  }
}

class _$RegisterModules extends _i7.RegisterModules {}
