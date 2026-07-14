class EventConfigModel {
  final String eventName;
  final DateTime eventStartTime;
  final int eventDurationHours;
  final DateTime raceStartTime;

  const EventConfigModel({
    required this.eventName,
    required this.eventStartTime,
    required this.eventDurationHours,
    required this.raceStartTime,
  });

  factory EventConfigModel.fromJson(Map<String, dynamic> json) {
    return EventConfigModel(
      eventName: json['eventName'] as String? ?? 'Bezradoor',
      eventStartTime: DateTime.parse(json['eventStartTime'] as String),
      eventDurationHours: json['eventDurationHours'] as int? ?? 5,
      raceStartTime: DateTime.parse(json['raceStartTime'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'eventName': eventName,
    'eventStartTime': eventStartTime.toIso8601String(),
    'eventDurationHours': eventDurationHours,
    'raceStartTime': raceStartTime.toIso8601String(),
  };
}