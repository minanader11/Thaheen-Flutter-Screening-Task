import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/job_order_model.dart';

class JobOrderPdfService {
  static const PdfColor borderColor = PdfColors.black;
  static const double borderWidth = 0.8;
  static const double cellPadding = 2.0;

  static pw.Border get defaultBorder => pw.Border.all(
        color: borderColor,
        width: borderWidth,
      );

  static Future<Uint8List> generateJobOrderPdf(JobOrderModel model) async {
    final regularFontData =
        await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    final boldFontData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
    final semiBoldFontData =
        await rootBundle.load('assets/fonts/Cairo-SemiBold.ttf');

    final ttfRegular = pw.Font.ttf(regularFontData);
    final ttfBold = pw.Font.ttf(boldFontData);
    final ttfSemiBold = pw.Font.ttf(semiBoldFontData);

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: ttfRegular,
        bold: ttfBold,
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: defaultBorder,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _buildHeader(model, ttfBold, ttfRegular),
                _buildJobTypeRow(model, ttfBold, ttfRegular),
                _buildReportAndClientSection(model, ttfBold, ttfRegular),
                _buildVisitInformationSection(model, ttfBold, ttfRegular),
                _buildFaultsAndActionsSection(model, ttfBold, ttfRegular),
                _buildTechnicalAndSparePartsSection(
                    model, ttfBold, ttfRegular, ttfSemiBold),
                _buildRemarksSection(model, ttfBold, ttfRegular),
                _buildSignaturesSection(model, ttfBold, ttfRegular),
                _buildFooterSection(model, ttfRegular),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 1. Header: Logo, Title, Job No Box
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildHeader(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      height: 44,
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Row(
        children: [
          // Left: Logo & Company Name
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: pw.Row(
              children: [
                // Custom drawn tech logo mark
                pw.Container(
                  width: 22,
                  height: 22,
                  margin: const pw.EdgeInsets.only(right: 4),
                  child: pw.CustomPaint(
                    painter: (PdfGraphics canvas, PdfPoint size) {
                      canvas.setColor(PdfColors.black);
                      // Draw stylized triangular / origami tech icon
                      canvas.moveTo(size.x * 0.1, size.y * 0.1);
                      canvas.lineTo(size.x * 0.9, size.y * 0.1);
                      canvas.lineTo(size.x * 0.5, size.y * 0.95);
                      canvas.closePath();
                      canvas.fillPath();

                      canvas.setColor(PdfColors.white);
                      canvas.moveTo(size.x * 0.35, size.y * 0.3);
                      canvas.lineTo(size.x * 0.65, size.y * 0.3);
                      canvas.lineTo(size.x * 0.5, size.y * 0.65);
                      canvas.closePath();
                      canvas.fillPath();
                    },
                  ),
                ),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'ALFA ELECTRONICS',
                      style: pw.TextStyle(
                        font: bold,
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'ألفا للإلكترونيات',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        font: bold,
                        fontSize: 8.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Center: Title
          pw.Expanded(
            child: pw.Center(
              child: pw.Text(
                'Job Order',
                style: pw.TextStyle(
                  font: bold,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),

          // Right: Job No box
          pw.Container(
            width: 100,
            decoration: pw.BoxDecoration(
              border: pw.Border(left: pw.BorderSide(color: borderColor, width: borderWidth)),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'رقم : ',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: bold, fontSize: 8),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: borderColor, width: 0.6),
                  ),
                  child: pw.Text(
                    model.jobOrderNo.isEmpty ? '     ' : model.jobOrderNo,
                    style: pw.TextStyle(font: bold, fontSize: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 2. Job Type Row (6 options)
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildJobTypeRow(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    final types = [
      {'type': JobType.installation, 'en': 'Installation', 'ar': 'تركيب'},
      {'type': JobType.reinstallation, 'en': 'Reinstallation', 'ar': 'إعادة تركيب'},
      {'type': JobType.pm, 'en': 'PM', 'ar': 'صيانة'},
      {'type': JobType.emergency, 'en': 'Emergency', 'ar': 'حالات طوارئ'},
      {'type': JobType.annualPm, 'en': 'Annual PM', 'ar': 'صيانة سنوية'},
      {'type': JobType.other, 'en': 'Other', 'ar': 'أخرى'},
    ];

    return pw.Container(
      height: 28,
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Row(
        children: types.map((item) {
          final isChecked = model.selectedJobType == item['type'];
          final isLast = item == types.last;

          return pw.Expanded(
            child: pw.Container(
              decoration: isLast
                  ? null
                  : pw.BoxDecoration(
                      border: pw.Border(
                        right: pw.BorderSide(color: borderColor, width: borderWidth),
                      ),
                    ),
              padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(width: 3),
                  _buildCheckbox(isChecked: isChecked),
                  pw.SizedBox(width: 4),
                  pw.Expanded(
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          item['en'] as String,
                          style: pw.TextStyle(font: reg, fontSize: 6.8),
                        ),
                        pw.Text(
                          item['ar'] as String,
                          textDirection: pw.TextDirection.rtl,
                          style: pw.TextStyle(font: reg, fontSize: 6.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 3. Report (Left) & Client Info (Right) Section
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildReportAndClientSection(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // ── LEFT COLUMN: الإبلاغ ──
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(color: borderColor, width: borderWidth),
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // Title: الإبلاغ
                  pw.Container(
                    height: 14,
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'الإبلاغ',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: bold, fontSize: 7.5),
                      ),
                    ),
                  ),
                  _buildHDivider(),

                  // Row: Date & Time
                  pw.Container(
                    height: 18,
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 34,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Text('Date', style: pw.TextStyle(font: reg, fontSize: 7)),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: borderColor, width: 0.5),
                                right: pw.BorderSide(color: borderColor, width: 0.5),
                              ),
                            ),
                            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  model.reportDate,
                                  style: pw.TextStyle(font: reg, fontSize: 7),
                                ),
                                pw.Text('V', style: pw.TextStyle(font: bold, fontSize: 6)),
                              ],
                            ),
                          ),
                        ),
                        pw.Container(
                          width: 32,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 3),
                          child: pw.Text('Time', style: pw.TextStyle(font: reg, fontSize: 7)),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 3),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  model.reportTime,
                                  style: pw.TextStyle(font: reg, fontSize: 7),
                                ),
                                pw.Text('V', style: pw.TextStyle(font: bold, fontSize: 6)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildHDivider(),

                  // Row: Client ID & Printer ID
                  pw.Container(
                    height: 18,
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 50,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Text('Client ID', style: pw.TextStyle(font: reg, fontSize: 7)),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: borderColor, width: 0.5),
                                right: pw.BorderSide(color: borderColor, width: 0.5),
                              ),
                            ),
                            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(model.clientId, style: pw.TextStyle(font: reg, fontSize: 7)),
                          ),
                        ),
                        pw.Container(
                          width: 46,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Text('Printer ID', style: pw.TextStyle(font: reg, fontSize: 6.5)),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(model.printerId, style: pw.TextStyle(font: reg, fontSize: 7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildHDivider(),

                  // Row: Calling Person
                  _buildFieldRow('Calling Person', model.callingPerson, reg, height: 18),
                  _buildHDivider(),

                  // Row: Symptom العطل
                  pw.Container(
                    height: 22,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                          width: 68,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Row(
                            children: [
                              pw.Text('Symptom', style: pw.TextStyle(font: reg, fontSize: 7)),
                              pw.Text('العطل', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: reg, fontSize: 7)),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: borderColor, width: 0.5),
                              ),
                            ),
                            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              model.symptom,
                              style: pw.TextStyle(font: reg, fontSize: 7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildHDivider(),

                  // Row: Notes
                  pw.Container(
                    height: 38,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 40,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: pw.Text('Notes', style: pw.TextStyle(font: reg, fontSize: 7)),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: borderColor, width: 0.5),
                              ),
                            ),
                            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              model.reportNotes,
                              textDirection: pw.TextDirection.rtl,
                              style: pw.TextStyle(font: reg, fontSize: 6.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── RIGHT COLUMN: بيانات العميل ──
          pw.Expanded(
            flex: 1,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Header: Ref.No. & بيانات العميل
                pw.Container(
                  height: 14,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 6),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'بيانات العميل',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: bold, fontSize: 7.5),
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            'رقم الإبلاغ : Ref.No.',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: bold, fontSize: 7),
                          ),
                          if (model.refNo.isNotEmpty) ...[
                            pw.SizedBox(width: 4),
                            pw.Text(model.refNo, style: pw.TextStyle(font: reg, fontSize: 7)),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                _buildHDivider(),

                _buildFieldRow('Client Name', model.clientName, reg, height: 18),
                _buildHDivider(),

                _buildFieldRow('Address', model.address, reg, height: 18),
                _buildHDivider(),

                _buildFieldRow('Tel No', model.telNo, reg, height: 14),
                _buildHDivider(),

                _buildFieldRow('Mobile No', model.mobileNo, reg, height: 14),
                _buildHDivider(),

                _buildFieldRow('Person in Charge', model.personInCharge, reg, height: 14),
                _buildHDivider(),

                _buildFieldRow('Printer S/N', model.printerSn, reg, height: 15),
                _buildHDivider(),

                // Assigned & Maintenance Contract row
                pw.Container(
                  height: 20,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Text(
                            'نوع الصيانة / عقد صيانة',
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(font: reg, fontSize: 6.5),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border(
                              left: pw.BorderSide(color: borderColor, width: 0.5),
                            ),
                          ),
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Row(
                                children: [
                                  pw.Text('Assigned : ', style: pw.TextStyle(font: bold, fontSize: 6.5)),
                                  pw.Text(model.assignedEngineer, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                                ],
                              ),
                              pw.Row(
                                children: [
                                  pw.Text('Backup : ', style: pw.TextStyle(font: bold, fontSize: 6.5)),
                                  pw.Text(model.backupEngineer, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 4. Visit Information Section
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildVisitInformationSection(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Header with Visit Type Radio/Checkboxes
          pw.Container(
            height: 16,
            padding: const pw.EdgeInsets.symmetric(horizontal: 6),
            child: pw.Row(
              children: [
                pw.Text(
                  'Visit Information',
                  style: pw.TextStyle(font: bold, fontSize: 7.5),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  'بيانات الزيارة',
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: bold, fontSize: 7.5),
                ),
                pw.Spacer(),
                _buildCheckbox(isChecked: model.visitType == VisitType.atSite),
                pw.SizedBox(width: 3),
                pw.Text('At Site', style: pw.TextStyle(font: bold, fontSize: 7)),
                pw.SizedBox(width: 14),
                _buildCheckbox(isChecked: model.visitType == VisitType.byPhone),
                pw.SizedBox(width: 3),
                pw.Text('By Phone', style: pw.TextStyle(font: reg, fontSize: 7)),
                pw.SizedBox(width: 14),
                _buildCheckbox(isChecked: model.visitType == VisitType.serviceCenter),
                pw.SizedBox(width: 3),
                pw.Text('Service Center', style: pw.TextStyle(font: reg, fontSize: 7)),
                pw.SizedBox(width: 6),
              ],
            ),
          ),
          _buildHDivider(),

          // Date & Dispatched
          pw.Container(
            height: 14,
            padding: const pw.EdgeInsets.symmetric(horizontal: 6),
            child: pw.Row(
              children: [
                pw.Text('Date : ', style: pw.TextStyle(font: bold, fontSize: 7)),
                pw.Text(model.visitDate.isEmpty ? '     /     / 202 ' : model.visitDate,
                    style: pw.TextStyle(font: reg, fontSize: 7)),
                pw.SizedBox(width: 30),
                pw.Text('Dispatched : ', style: pw.TextStyle(font: bold, fontSize: 7)),
                pw.Text(model.dispatched, style: pw.TextStyle(font: reg, fontSize: 7)),
              ],
            ),
          ),

          // 6 Time Stages
          pw.Container(
            height: 38,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: borderColor, width: 0.5),
                bottom: pw.BorderSide(color: borderColor, width: 0.5),
              ),
            ),
            child: pw.Row(
              children: [
                _buildTimeBox('Company Left', model.companyLeftTime, bold, reg),
                _buildTimeBox('Site Arrival', model.siteArrivalTime, bold, reg),
                _buildTimeBox('Service Start', model.serviceStartTime, bold, reg),
                _buildTimeBox('Service End', model.serviceEndTime, bold, reg),
                _buildTimeBox('Site Left', model.siteLeftTime, bold, reg),
                _buildTimeBox('Company Back', model.companyBackTime, bold, reg, isLast: true),
              ],
            ),
          ),

          // Bottom visit actions
          pw.Container(
            height: 15,
            padding: const pw.EdgeInsets.symmetric(horizontal: 6),
            child: pw.Row(
              children: [
                _buildCheckbox(isChecked: model.returnToAlfaOrHome),
                pw.SizedBox(width: 3),
                pw.Text('Return to ALFA / Home', style: pw.TextStyle(font: reg, fontSize: 6.5)),
                pw.SizedBox(width: 14),
                _buildCheckbox(isChecked: model.proceedToAnotherCall),
                pw.SizedBox(width: 3),
                pw.Text('Proceed To another Call', style: pw.TextStyle(font: reg, fontSize: 6.5)),
                pw.Spacer(),
                pw.Text('Next Service Report Ref. No. ', style: pw.TextStyle(font: bold, fontSize: 6.5)),
                pw.Text(model.nextServiceReportRefNo, style: pw.TextStyle(font: reg, fontSize: 6.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 5. Faults & Actions Section (Tabular with Code Columns)
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildFaultsAndActionsSection(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Column(
        children: [
          // Header Row 1: Fault & Action
          pw.Container(
            height: 14,
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: 0.5)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 9,
                  child: pw.Center(
                    child: pw.Text('Fault (العطل)', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                      right: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text('الكود', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: bold, fontSize: 6.5)),
                  ),
                ),
                pw.Expanded(
                  flex: 9,
                  child: pw.Center(
                    child: pw.Text('Action (الإجراء المتخذ)', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text('الكود', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: bold, fontSize: 6.5)),
                  ),
                ),
              ],
            ),
          ),

          // Content Row 1: Values for Fault & Action
          pw.Container(
            height: 70,
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: 0.5)),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 9,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(
                      model.faultDescription,
                      style: pw.TextStyle(font: reg, fontSize: 6.5),
                    ),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                      right: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text(model.faultCode, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
                pw.Expanded(
                  flex: 9,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(
                      model.actionDescription,
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: reg, fontSize: 6.5),
                    ),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text(model.actionCode, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
              ],
            ),
          ),

          // Header Row 2: Cause & Responsible
          pw.Container(
            height: 14,
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: 0.5)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 9,
                  child: pw.Center(
                    child: pw.Text('Cause (السبب)', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                      right: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text('الكود', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: bold, fontSize: 6.5)),
                  ),
                ),
                pw.Expanded(
                  flex: 9,
                  child: pw.Center(
                    child: pw.Text('Responsible (المسؤول)', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text('الكود', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: bold, fontSize: 6.5)),
                  ),
                ),
              ],
            ),
          ),

          // Content Row 2: Values for Cause & Responsible
          pw.Container(
            height: 65,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 9,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(
                      model.causeDescription,
                      style: pw.TextStyle(font: reg, fontSize: 6.5),
                    ),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                      right: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text(model.causeCode, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
                pw.Expanded(
                  flex: 9,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(
                      model.responsibleDescription,
                      style: pw.TextStyle(font: reg, fontSize: 6.5),
                    ),
                  ),
                ),
                pw.Container(
                  width: 38,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: borderColor, width: 0.5),
                    ),
                  ),
                  child: pw.Center(
                    child: pw.Text(model.responsibleCode, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 6. Technical Parameters & Spare Parts Section
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildTechnicalAndSparePartsSection(
      JobOrderModel model, pw.Font bold, pw.Font reg, pw.Font semiBold) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Measurement Row: P(nb), P(ac), Jet(1), Jet(2), Vacuum, Vesco
          pw.Container(
            height: 15,
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: 0.5)),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _buildParamTag('P(nb) :', model.pNb, bold, reg),
                _buildParamTag('P(ac) :', model.pAc, bold, reg),
                _buildParamTag('Jet(1) :', model.jet1, bold, reg),
                _buildParamTag('Jet(2) :', model.jet2, bold, reg),
                _buildParamTag('Vacuum :', model.vacuum, bold, reg),
                _buildParamTag('Vesco :', model.vesco, bold, reg),
              ],
            ),
          ),

          // Two Columns: Left = Parameters & Condition; Right = Spare Parts Table
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left: Parameters & Call Condition
              pw.Container(
                width: 175,
                decoration: pw.BoxDecoration(
                  border: pw.Border(right: pw.BorderSide(color: borderColor, width: 0.5)),
                ),
                padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        _buildParamTag('T :', model.t, bold, reg, width: 45),
                        _buildParamTag('Working Hr. :', model.workingHr, bold, reg),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      children: [
                        _buildParamTag('Vm :', model.vm, bold, reg, width: 45),
                        _buildParamTag('S/W Version :', model.swVersion, bold, reg),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text('Call Condition', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                    pw.SizedBox(height: 1),
                    pw.Row(
                      children: [
                        _buildCheckbox(isChecked: model.callCondition == CallCondition.closed),
                        pw.SizedBox(width: 3),
                        pw.Text('Closed', style: pw.TextStyle(font: reg, fontSize: 6.5)),
                        pw.SizedBox(width: 10),
                        _buildCheckbox(isChecked: model.callCondition == CallCondition.followUp),
                        pw.SizedBox(width: 3),
                        pw.Text('Follow up', style: pw.TextStyle(font: reg, fontSize: 6.5)),
                      ],
                    ),
                  ],
                ),
              ),

              // Right: Spare Parts Table ("قطع الغيار التي تم تركيبها")
              pw.Expanded(
                child: pw.Column(
                  children: [
                    // Header Row
                    pw.Container(
                      height: 14,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: 0.5)),
                      ),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 6,
                            child: pw.Center(
                              child: pw.Text('قطع الغيار التي تم تركيبها',
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(font: bold, fontSize: 5.8)),
                            ),
                          ),
                          _buildVDivider(),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Center(
                              child: pw.Text('الكمية',
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(font: bold, fontSize: 5.8)),
                            ),
                          ),
                          _buildVDivider(),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Center(
                              child: pw.Text('سعر الوحدة',
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(font: bold, fontSize: 5.8)),
                            ),
                          ),
                          _buildVDivider(),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Center(
                              child: pw.Text('الخصمان',
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(font: bold, fontSize: 5.8)),
                            ),
                          ),
                          _buildVDivider(),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Center(
                              child: pw.Text('الضمان',
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(font: bold, fontSize: 5.8)),
                            ),
                          ),
                          _buildVDivider(),
                          pw.Container(
                            width: 48,
                            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                _buildCheckbox(isChecked: model.spareParts.isNotEmpty && model.spareParts.first.isClient),
                                pw.SizedBox(width: 2),
                                pw.Text('Client', style: pw.TextStyle(font: reg, fontSize: 5.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Spare parts rows (display at least 2 rows)
                    ...List.generate(
                      model.spareParts.length < 2 ? 2 : model.spareParts.length,
                      (index) {
                        final item = index < model.spareParts.length
                            ? model.spareParts[index]
                            : const SparePartItem();
                        final isLastRow = index == (model.spareParts.length < 2 ? 1 : model.spareParts.length - 1);

                        return pw.Container(
                          height: 13,
                          decoration: isLastRow
                              ? null
                              : pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(color: borderColor, width: 0.5)),
                                ),
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                flex: 6,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                                  child: pw.Text(item.description,
                                      textDirection: pw.TextDirection.rtl,
                                      style: pw.TextStyle(font: reg, fontSize: 6)),
                                ),
                              ),
                              _buildVDivider(),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Center(
                                  child: pw.Text(item.quantity, style: pw.TextStyle(font: reg, fontSize: 6)),
                                ),
                              ),
                              _buildVDivider(),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Center(
                                  child: pw.Text(item.unitPrice, style: pw.TextStyle(font: reg, fontSize: 6)),
                                ),
                              ),
                              _buildVDivider(),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Center(
                                  child: pw.Text(item.discount, style: pw.TextStyle(font: reg, fontSize: 6)),
                                ),
                              ),
                              _buildVDivider(),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Center(
                                  child: pw.Text(item.warranty, style: pw.TextStyle(font: reg, fontSize: 6)),
                                ),
                              ),
                              _buildVDivider(),
                              pw.Container(
                                width: 48,
                                padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  children: [
                                    _buildCheckbox(isChecked: item.isAlfa),
                                    pw.SizedBox(width: 2),
                                    pw.Text('ALFA', style: pw.TextStyle(font: reg, fontSize: 5.5)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 7. Remarks Section
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildRemarksSection(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      height: 38,
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            height: 12,
            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Remarks', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                pw.Text('ملاحظات', textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: bold, fontSize: 6.8)),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: pw.Text(
                model.remarks,
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(font: reg, fontSize: 6.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 8. Signatures & Approvals Section
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildSignaturesSection(
      JobOrderModel model, pw.Font bold, pw.Font reg) {
    return pw.Container(
      height: 58,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Left: Client Signature
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border(right: pw.BorderSide(color: borderColor, width: 0.5)),
              ),
              padding: const pw.EdgeInsets.all(6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Client Signature :', style: pw.TextStyle(font: bold, fontSize: 7)),
                  if (model.clientSignature.isNotEmpty) ...[
                    pw.Spacer(),
                    pw.Text(model.clientSignature, style: pw.TextStyle(font: reg, fontSize: 7)),
                  ],
                ],
              ),
            ),
          ),

          // Right: Engineer & Approvals
          pw.Expanded(
            flex: 1,
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Row(
                    children: [
                      pw.Text('Engineer Name : ', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                      pw.Text(model.engineerName, style: pw.TextStyle(font: reg, fontSize: 6.8)),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text('Reviewed By : ', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                      pw.Text(model.reviewedBy, style: pw.TextStyle(font: reg, fontSize: 6.8)),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text('Authorized By : ', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                      pw.Text(model.authorizedBy, style: pw.TextStyle(font: reg, fontSize: 6.8)),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text('Data Entered by : ', style: pw.TextStyle(font: bold, fontSize: 6.8)),
                      pw.Text(model.dataEnteredBy, style: pw.TextStyle(font: reg, fontSize: 6.8)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 9. Document Footer (F-04-08 and Rev1)
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildFooterSection(JobOrderModel model, pw.Font reg) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: borderColor, width: borderWidth)),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(model.formCode, style: pw.TextStyle(font: reg, fontSize: 6)),
          pw.Text(model.revisionCode, style: pw.TextStyle(font: reg, fontSize: 6)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helper Widgets: Checkboxes, Dividers, Field Rows, Time Boxes
  // ─────────────────────────────────────────────────────────────────────────
  static pw.Widget _buildCheckbox({required bool isChecked}) {
    return pw.Container(
      width: 7.5,
      height: 7.5,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: isChecked ? PdfColor.fromInt(0xFF007ACC) : borderColor,
          width: 0.7,
        ),
        color: isChecked ? PdfColor.fromInt(0xFF007ACC) : null,
      ),
      child: isChecked
          ? pw.Center(
              child: pw.CustomPaint(
                painter: (PdfGraphics canvas, PdfPoint size) {
                  canvas.setColor(PdfColors.white);
                  canvas.setLineWidth(1.1);
                  canvas.moveTo(size.x * 0.15, size.y * 0.5);
                  canvas.lineTo(size.x * 0.45, size.y * 0.15);
                  canvas.lineTo(size.x * 0.88, size.y * 0.85);
                  canvas.strokePath();
                },
              ),
            )
          : null,
    );
  }

  static pw.Widget _buildHDivider() {
    return pw.Container(
      height: 0.5,
      color: borderColor,
    );
  }

  static pw.Widget _buildVDivider() {
    return pw.Container(
      width: 0.5,
      color: borderColor,
    );
  }

  static pw.Widget _buildFieldRow(String label, String value, pw.Font reg,
      {double height = 16}) {
    return pw.Container(
      height: height,
      child: pw.Row(
        children: [
          pw.Container(
            width: 78,
            padding: const pw.EdgeInsets.symmetric(horizontal: 4),
            child: pw.Text(label, style: pw.TextStyle(font: reg, fontSize: 6.8)),
          ),
          pw.Expanded(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: borderColor, width: 0.5)),
              ),
              padding: const pw.EdgeInsets.symmetric(horizontal: 4),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(value, style: pw.TextStyle(font: reg, fontSize: 6.8)),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTimeBox(
      String label, String timeStr, pw.Font bold, pw.Font reg,
      {bool isLast = false}) {
    // Parse time into HH and MM
    String hh = '  ';
    String mm = '  ';
    if (timeStr.contains(':')) {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        hh = parts[0].trim();
        mm = parts[1].trim();
      }
    }

    return pw.Expanded(
      child: pw.Container(
        decoration: isLast
            ? null
            : pw.BoxDecoration(
                border: pw.Border(right: pw.BorderSide(color: borderColor, width: 0.5)),
              ),
        padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 1),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              label,
              style: pw.TextStyle(font: reg, fontSize: 5.8),
              textAlign: pw.TextAlign.center,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  width: 14,
                  height: 14,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: borderColor, width: 0.5),
                  ),
                  child: pw.Center(
                    child: pw.Text(hh, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                  child: pw.Text(':', style: pw.TextStyle(font: bold, fontSize: 6.5)),
                ),
                pw.Container(
                  width: 14,
                  height: 14,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: borderColor, width: 0.5),
                  ),
                  child: pw.Center(
                    child: pw.Text(mm, style: pw.TextStyle(font: reg, fontSize: 6.5)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildParamTag(
      String label, String value, pw.Font bold, pw.Font reg,
      {double? width}) {
    return pw.Container(
      width: width,
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(label, style: pw.TextStyle(font: bold, fontSize: 6.2)),
          pw.SizedBox(width: 2),
          pw.Text(value.isEmpty ? '     ' : value, style: pw.TextStyle(font: reg, fontSize: 6.2)),
        ],
      ),
    );
  }
}
