import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../../core/styles/colors.dart';
import '../../model/job_order_model.dart';
import '../../services/job_order_pdf_service.dart';

class JobOrderPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;
  final JobOrderModel model;

  const JobOrderPreviewScreen({
    super.key,
    required this.pdfBytes,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final fileName =
        'Job_Order_${model.jobOrderNo.isNotEmpty ? model.jobOrderNo : 'Document'}.pdf';

    return Scaffold(
      backgroundColor: const Color(0xFF07111E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1624),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Order #${model.jobOrderNo}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              'ALFA ELECTRONICS - ألفا للإلكترونيات',
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Share PDF',
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () async {
              await Printing.sharePdf(
                bytes: pdfBytes,
                filename: fileName,
              );
            },
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) async => pdfBytes,
        initialPageFormat: PdfPageFormat.a4,
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName: fileName,
        loadingWidget: const Center(
          child: CircularProgressIndicator(color: ColorManager.primary),
        ),
      ),
    );
  }
}
