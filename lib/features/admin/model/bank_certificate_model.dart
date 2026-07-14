class BankCertificateModel {
  final int id;
  final int durationMinutes;
  final double percentageGain;

  const BankCertificateModel({
    required this.id,
    required this.durationMinutes,
    required this.percentageGain,
  });

  factory BankCertificateModel.fromJson(Map<String, dynamic> json) {
    return BankCertificateModel(
      id: json['id'] as int,
      durationMinutes: json['durationMinutes'] as int,
      percentageGain: (json['percentageGain'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'durationMinutes': durationMinutes,
    'percentageGain': percentageGain,
  };
}