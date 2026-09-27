import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../model/job_order_model.dart';
import '../services/job_order_pdf_service.dart';
import 'job_order_state.dart';

@injectable
class JobOrderCubit extends Cubit<JobOrderState> {
  JobOrderCubit() : super(JobOrderState.initial());

  void updateModel(JobOrderModel newModel) {
    emit(state.copyWith(jobOrder: newModel));
  }

  void loadSampleData() {
    emit(state.copyWith(
      jobOrder: JobOrderModel.sample(),
      pdfStatus: JobOrderPdfStatus.initial,
      generatedPdfBytes: null,
    ));
  }

  void clearForm() {
    emit(state.copyWith(
      jobOrder: const JobOrderModel(),
      pdfStatus: JobOrderPdfStatus.initial,
      generatedPdfBytes: null,
    ));
  }

  // ── Job Type ─────────────────────────────────────────────────────────────
  void selectJobType(JobType jobType) {
    emit(state.copyWith(
      jobOrder: state.jobOrder.copyWith(selectedJobType: jobType),
    ));
  }

  // ── Visit Type ───────────────────────────────────────────────────────────
  void selectVisitType(VisitType visitType) {
    emit(state.copyWith(
      jobOrder: state.jobOrder.copyWith(visitType: visitType),
    ));
  }

  // ── Call Condition ───────────────────────────────────────────────────────
  void selectCallCondition(CallCondition condition) {
    emit(state.copyWith(
      jobOrder: state.jobOrder.copyWith(callCondition: condition),
    ));
  }

  // ── Spare Parts ──────────────────────────────────────────────────────────
  void addSparePart() {
    final updated = List<SparePartItem>.from(state.jobOrder.spareParts)
      ..add(const SparePartItem());
    emit(state.copyWith(
      jobOrder: state.jobOrder.copyWith(spareParts: updated),
    ));
  }

  void updateSparePart(int index, SparePartItem item) {
    if (index >= 0 && index < state.jobOrder.spareParts.length) {
      final updated = List<SparePartItem>.from(state.jobOrder.spareParts);
      updated[index] = item;
      emit(state.copyWith(
        jobOrder: state.jobOrder.copyWith(spareParts: updated),
      ));
    }
  }

  void removeSparePart(int index) {
    if (index >= 0 && index < state.jobOrder.spareParts.length) {
      final updated = List<SparePartItem>.from(state.jobOrder.spareParts)
        ..removeAt(index);
      emit(state.copyWith(
        jobOrder: state.jobOrder.copyWith(spareParts: updated),
      ));
    }
  }

  // ── PDF Generation ───────────────────────────────────────────────────────
  Future<void> generatePdf() async {
    emit(state.copyWith(pdfStatus: JobOrderPdfStatus.loading));
    try {
      final pdfBytes =
          await JobOrderPdfService.generateJobOrderPdf(state.jobOrder);
      emit(state.copyWith(
        pdfStatus: JobOrderPdfStatus.success,
        generatedPdfBytes: pdfBytes,
      ));
    } catch (e, stack) {
      log('Error generating PDF: $e\n$stack');
      emit(state.copyWith(
        pdfStatus: JobOrderPdfStatus.error,
        errorMessage: 'Failed to generate PDF: ${e.toString()}',
      ));
    }
  }
}
