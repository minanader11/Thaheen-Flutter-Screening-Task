     import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../model/job_order_model.dart';

enum JobOrderPdfStatus {
  initial,
  loading,
  success,
  error,
}

class JobOrderState extends Equatable {
  final JobOrderModel jobOrder;
  final JobOrderPdfStatus pdfStatus;
  final Uint8List? generatedPdfBytes;
  final String errorMessage;

  const JobOrderState({
    required this.jobOrder,
    this.pdfStatus = JobOrderPdfStatus.initial,
    this.generatedPdfBytes,
    this.errorMessage = '',
  });

  factory JobOrderState.initial() {
    return JobOrderState(
      jobOrder: JobOrderModel.sample(),
    );
  }

  JobOrderState copyWith({
    JobOrderModel? jobOrder,
    JobOrderPdfStatus? pdfStatus,
    Uint8List? generatedPdfBytes,
    String? errorMessage,
  }) {
    return JobOrderState(
      jobOrder: jobOrder ?? this.jobOrder,
      pdfStatus: pdfStatus ?? this.pdfStatus,
      generatedPdfBytes: generatedPdfBytes ?? this.generatedPdfBytes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        jobOrder,
        pdfStatus,
        generatedPdfBytes,
        errorMessage,
      ];
}
