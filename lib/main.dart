import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/cache_helper.dart';
import 'core/di/injection.dart';
import 'core/settings/view_model/settings_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();            // SharedPreferences must be ready first
  configureDependencies();             // get_it + injectable

  final settingsCubit = getIt<SettingsCubit>();
  await settingsCubit.loadSettings();  // read language/theme/speed before first frame

  runApp(MyApp(settingsCubit: settingsCubit));
}
