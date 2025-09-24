import 'package:base_project/core/get_it/dependecy_injection.dart';
import 'package:base_project/core/localization/localization_cubit/localization_cubit.dart';

void localizationDi() {
  getIt.registerLazySingleton<LocalizationCubit>(() => LocalizationCubit());
}
