// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:base_project/core/get_it/dependecy_injection.dart';
// import 'package:base_project/core/services/connectivity_check/connectivity_service/connectivity_service_interface.dart';
// import 'package:base_project/core/services/connectivity_check/cubit/connectivity_cubit.dart';
//
// void connectivityDI() {
//   // Register the ConnectivityRepository as a singleton
//   getIttt.registerSingleton<ConnectivityRepository>(
//     ConnectivityRepositoryImpl(Connectivity()),
//   );
//
//   // Register the ConnectivityCubit as a factory
//   getIttt.registerFactory<ConnectivityCubit>(
//     () => ConnectivityCubit(getIttt<ConnectivityRepository>()),
//   );
// }
