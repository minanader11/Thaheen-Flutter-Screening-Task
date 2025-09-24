import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

// Repository Interface
abstract class ConnectivityRepository {
  Future<List<ConnectivityResult>> checkInternetConnection();
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;

  ConnectivityRepositoryImpl(this._connectivity);

  @override
  Future<List<ConnectivityResult>> checkInternetConnection() async {
    return await _connectivity.checkConnectivity();
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
