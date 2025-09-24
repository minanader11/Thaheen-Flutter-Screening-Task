import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:base_project/core/get_it/dependecy_injection.dart';
import 'package:base_project/core/localization/generated/l10n.dart';
import 'package:base_project/core/services/connectivity_check/connectivity_service/connectivity_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final ConnectivityRepository _repository;
  StreamSubscription<ConnectivityStatus>? _connectivitySubscription;

  ConnectivityCubit(this._repository) : super(const ConnectivityState());

  Future<void> initialize() async {
    await _checkInitialStatus();
    _connectivitySubscription = _repository.onConnectivityChanged
        // 🔹 Step 1: map()
        // Transform the raw connectivity results (like [wifi], [none], [mobile])
        // into a simple ConnectivityStatus (connected/disconnected).
        // Example:
        //   Input: [wifi]  → Output: ConnectivityStatus.connected
        //   Input: [none]  → Output: ConnectivityStatus.disconnected
        .map(
          (results) => results.contains(ConnectivityResult.none)
              ? ConnectivityStatus.disconnected
              : ConnectivityStatus.connected,
        )
        // 🔹 Step 2: distinct()
        // Avoids emitting duplicate consecutive values.
        // Example:
        //   Before: [connected, connected, disconnected, disconnected, connected]
        //   After : [connected, disconnected, connected]
        // This prevents the Cubit from re-emitting the same state unnecessarily.
        .distinct()
        // 🔹 Step 3: switchMap()
        // Each new status creates a new inner stream.
        // If another status comes before the inner stream finishes,
        // the old one is cancelled (switched out).
        //
        // Why?
        // - We want to delay "disconnected" signals by 10s (debounce unstable Wi-Fi).
        // - If a "connected" event arrives within 10s, cancel the delayed "disconnected".
        //
        // Example timeline:
        //   t=0s → disconnected → wait 10s before emitting
        //   t=5s → connected arrives → cancel the pending disconnected, emit connected immediately
        //   Result: UI shows "connected" without flickering.
        .switchMap((status) {
      final delay =
          status.isDisconnected ? const Duration(seconds: 2) : Duration.zero;
      return Stream.value(status).delay(delay);
    }).listen(
      (status) => emit(
        state.copyWith(
          status: status,
          message: status.isDisconnected
              ? S
                  .of(getIt<GlobalKey<NavigatorState>>().currentContext!)
                  .NoInternetConnection
              : null,
        ),
      ),
      onError: (error) {
        emit(
          state.copyWith(
            status: ConnectivityStatus.disconnected,
            message: S
                .of(getIt<GlobalKey<NavigatorState>>().currentContext!)
                .NoInternetConnection,
          ),
        );
      },
    );
  }

  Future<void> _checkInitialStatus() async {
    try {
      final response = await _repository.checkInternetConnection();
      final internetConnectionStatus =
          response.contains(ConnectivityResult.none)
              ? ConnectivityStatus.disconnected
              : ConnectivityStatus.connected;
      emit(
        state.copyWith(
          status: internetConnectionStatus,
          message: internetConnectionStatus.isDisconnected
              ? S
                  .of(getIt<GlobalKey<NavigatorState>>().currentContext!)
                  .NoInternetConnection
              : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ConnectivityStatus.disconnected,
          message: S
              .of(getIt<GlobalKey<NavigatorState>>().currentContext!)
              .NoInternetConnection,
        ),
      );
    }
  }

  Future<void> checkConnectionOnResume() async => _checkInitialStatus();

  @override
  Future<void> close() async {
    await _connectivitySubscription?.cancel();
    return super.close();
  }
}
