// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum ConnectivityStatus { initial, connected, disconnected }

extension ConnectivityStatusX on ConnectivityStatus {
  bool get isInitial => this == ConnectivityStatus.initial;
  bool get isConnected => this == ConnectivityStatus.connected;
  bool get isDisconnected => this == ConnectivityStatus.disconnected;
}

class ConnectivityState extends Equatable {
  final ConnectivityStatus status;
  final String? message;

  const ConnectivityState({
    this.status = ConnectivityStatus.initial,
    this.message,
  });
  ConnectivityState copyWith({ConnectivityStatus? status, String? message}) {
    return ConnectivityState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
