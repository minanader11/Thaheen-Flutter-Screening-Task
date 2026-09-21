// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:LJF_admin/core/config/api_config.dart' as _i218;
import 'package:LJF_admin/core/config/production_config.dart' as _i872;
import 'package:LJF_admin/core/config/test_api_config.dart' as _i340;
import 'package:LJF_admin/core/local_storage/cache_helper.dart' as _i767;
import 'package:LJF_admin/core/localization/localization_cubit/localization_cubit.dart'
    as _i43;
import 'package:LJF_admin/core/networking/api_client/api_client.dart' as _i955;
import 'package:LJF_admin/core/networking/api_client/request_executer.dart'
    as _i576;
import 'package:LJF_admin/core/networking/dio_helper/dio_helper.dart' as _i717;
import 'package:LJF_admin/core/networking/error_handle/dio_error_parser.dart'
    as _i610;
import 'package:LJF_admin/core/networking/error_handle/error_parser.dart'
    as _i725;
import 'package:LJF_admin/core/networking/interceptors/interceptor_handler.dart'
    as _i47;
import 'package:LJF_admin/core/networking/interceptors/interceptor_handler_imp.dart'
    as _i737;
import 'package:LJF_admin/core/networking/refresh_token_handler/refresh_token_handler_impl.dart'
    as _i768;
import 'package:LJF_admin/core/networking/refresh_token_handler/refresh_token_hanlder.dart'
    as _i886;
import 'package:LJF_admin/features/admin/repo/admin_repo.dart' as _i323;
import 'package:LJF_admin/features/admin/repo/admin_repo_impl.dart' as _i511;
import 'package:LJF_admin/features/admin/view_model/admin_cubit.dart' as _i321;
import 'package:LJF_admin/features/job_order/view_model/job_order_cubit.dart'
    as _i799;

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
    gh.factory<_i799.JobOrderCubit>(() => _i799.JobOrderCubit());
    gh.lazySingleton<_i767.CacheHelper>(() => _i767.CacheHelper());
    gh.lazySingleton<_i43.LocalizationCubit>(() => _i43.LocalizationCubit());
    gh.lazySingleton<_i725.ErrorParser>(() => _i610.DioErrorParser());
    gh.lazySingleton<_i47.InterceptorsHandler>(
        () => _i737.InterceptorHandlerImp());
    gh.lazySingleton<_i218.ApiConfiguration>(
      () => _i340.TestApiConfiguration(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i218.ApiConfiguration>(
      () => _i872.ProductionApiConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i886.RefreshTokenHandler>(
        () => _i768.RefreshTokenHandlerImpl(gh<_i218.ApiConfiguration>()));
    gh.lazySingleton<_i361.Dio>(
        () => registerModule.dio(gh<_i218.ApiConfiguration>()));
    gh.lazySingleton<_i955.ApiClient>(() => _i955.ApiClient(
          dio: gh<_i361.Dio>(),
          errorParser: gh<_i725.ErrorParser>(),
        ));
    gh.lazySingleton<_i717.DioHelper>(() => _i717.DioHelper(
          gh<_i47.InterceptorsHandler>(),
          gh<_i218.ApiConfiguration>(),
        ));
    gh.lazySingleton<_i576.RequestExecutor>(() => _i576.RequestExecutor(
          gh<_i361.Dio>(),
          gh<_i725.ErrorParser>(),
        ));
    gh.lazySingleton<_i323.AdminRepo>(
        () => _i511.AdminRepoImpl(apiClient: gh<_i955.ApiClient>()));
    gh.factory<_i321.AdminCubit>(
        () => _i321.AdminCubit(repo: gh<_i323.AdminRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i576.RegisterModule {}
