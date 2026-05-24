// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_project/core/config/api_config.dart' as _i618;
import 'package:base_project/core/config/production_config.dart' as _i554;
import 'package:base_project/core/config/test_api_config.dart' as _i442;
import 'package:base_project/core/local_storage/cache_helper.dart' as _i1047;
import 'package:base_project/core/localization/localization_cubit/localization_cubit.dart'
    as _i486;
import 'package:base_project/core/networking/api_client/api_client.dart'
    as _i600;
import 'package:base_project/core/networking/api_client/request_executer.dart'
    as _i167;
import 'package:base_project/core/networking/dio_helper/dio_helper.dart'
    as _i263;
import 'package:base_project/core/networking/error_handle/dio_error_parser.dart'
    as _i929;
import 'package:base_project/core/networking/error_handle/error_parser.dart'
    as _i694;
import 'package:base_project/core/networking/interceptors/interceptor_handler.dart'
    as _i423;
import 'package:base_project/core/networking/interceptors/interceptor_handler_imp.dart'
    as _i132;
import 'package:base_project/core/networking/refresh_token_handler/refresh_token_handler_impl.dart'
    as _i292;
import 'package:base_project/core/networking/refresh_token_handler/refresh_token_hanlder.dart'
    as _i639;
import 'package:base_project/features/admin/repo/admin_repo.dart' as _i477;
import 'package:base_project/features/admin/repo/admin_repo_impl.dart' as _i988;
import 'package:base_project/features/admin/view_model/admin_cubit.dart'
    as _i1019;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _test = 'test';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i486.LocalizationCubit>(() => _i486.LocalizationCubit());
    gh.lazySingleton<_i1047.CacheHelper>(() => _i1047.CacheHelper());
    gh.lazySingleton<_i694.ErrorParser>(() => _i929.DioErrorParser());
    gh.lazySingleton<_i618.ApiConfiguration>(
      () => _i442.TestApiConfiguration(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i423.InterceptorsHandler>(
        () => _i132.InterceptorHandlerImp());
    gh.lazySingleton<_i618.ApiConfiguration>(
      () => _i554.ProductionApiConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i263.DioHelper>(() => _i263.DioHelper(
          gh<_i423.InterceptorsHandler>(),
          gh<_i618.ApiConfiguration>(),
        ));
    gh.lazySingleton<_i361.Dio>(
        () => registerModule.dio(gh<_i618.ApiConfiguration>()));
    gh.lazySingleton<_i167.RequestExecutor>(() => _i167.RequestExecutor(
          gh<_i361.Dio>(),
          gh<_i694.ErrorParser>(),
        ));
    gh.lazySingleton<_i639.RefreshTokenHandler>(
        () => _i292.RefreshTokenHandlerImpl(gh<_i618.ApiConfiguration>()));
    gh.lazySingleton<_i600.ApiClient>(() => _i600.ApiClient(
          dio: gh<_i361.Dio>(),
          errorParser: gh<_i694.ErrorParser>(),
        ));
    gh.lazySingleton<_i477.AdminRepo>(
        () => _i988.AdminRepoImpl(apiClient: gh<_i600.ApiClient>()));
    gh.factory<_i1019.AdminCubit>(
        () => _i1019.AdminCubit(repo: gh<_i477.AdminRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i167.RegisterModule {}
