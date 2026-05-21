// import 'dart:async';
// import 'dart:convert';
//
//
// class SignalRService {
//   HubConnection? _hubConnection;
//
//   // ── Streams ───────────────────────────────────────────────
//   final _scoreUpdatedController =
//   StreamController<Map<String, dynamic>>.broadcast();
//   final _taskAddedController =
//   StreamController<Map<String, dynamic>>.broadcast();
//   final _taskDeletedController =
//   StreamController<int>.broadcast();
//
//   Stream<Map<String, dynamic>> get onScoreUpdated =>
//       _scoreUpdatedController.stream;
//   Stream<Map<String, dynamic>> get onTaskAdded =>
//       _taskAddedController.stream;
//   Stream<int> get onTaskDeleted => _taskDeletedController.stream;
//
//   // ── Connect ───────────────────────────────────────────────
//   Future<void> connect() async {
//     _hubConnection = HubConnectionBuilder()
//         .withUrl(EndPoints.hubUrl)
//         .withAutomaticReconnect()
//         .build();
//
//     // ── Listeners ─────────────────────────────────────────
//     _hubConnection!.on('ScoreUpdated', (message) {
//       final data = _parse(message);
//       if (data != null) _scoreUpdatedController.add(data);
//     });
//
//     _hubConnection!.on('TaskAdded', (message) {
//       final data = _parse(message);
//       if (data != null) _taskAddedController.add(data);
//     });
//
//     _hubConnection!.on('TaskDeleted', (message) {
//       if (message == null || message.isEmpty) return;
//       final raw = message[0];
//       if (raw is int) {
//         _taskDeletedController.add(raw);
//       } else if (raw is String) {
//         _taskDeletedController.add(int.tryParse(raw) ?? -1);
//       }
//     });
//
//     await _hubConnection!.start();
//   }
//
//   // ── Disconnect ────────────────────────────────────────────
//   Future<void> disconnect() async {
//     await _hubConnection?.stop();
//   }
//
//   // ── Parse helper ──────────────────────────────────────────
//   Map<String, dynamic>? _parse(List<Object?>? message) {
//     if (message == null || message.isEmpty) return null;
//     final raw = message[0];
//     if (raw is String) return jsonDecode(raw);
//     if (raw is Map<String, dynamic>) return raw;
//     return null;
//   }
//
//   // ── Dispose ───────────────────────────────────────────────
//   void dispose() {
//     _scoreUpdatedController.close();
//     _taskAddedController.close();
//     _taskDeletedController.close();
//     _hubConnection?.stop();
//   }
// }