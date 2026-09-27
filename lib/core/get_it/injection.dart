import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies([String? environment]) =>
    environment != null ? getIt.init(environment: environment) : getIt.init();