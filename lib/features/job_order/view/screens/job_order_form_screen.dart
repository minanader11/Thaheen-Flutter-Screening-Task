import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../model/job_order_model.dart';
import '../../view_model/job_order_cubit.dart';
import '../../view_model/job_order_state.dart';
import '../widgets/client_report_section_widget.dart';
import '../widgets/fault_action_section_widget.dart';
import '../widgets/job_header_section_widget.dart';
import '../widgets/remarks_signatures_widget.dart';
import '../widgets/technical_params_section_widget.dart';
import '../widgets/visit_info_section_widget.dart';
import 'job_order_preview_screen.dart';

class JobOrderFormScreen extends StatefulWidget {
  const JobOrderFormScreen({super.key});

  @override
  State<JobOrderFormScreen> createState() => _JobOrderFormScreenState();
}

class _JobOrderFormScreenState extends State<JobOrderFormScreen> {
  // Header
  final _jobNoController = TextEditingController();

  // Report
  final _reportDateController = TextEditingController();
  final _reportTimeController = TextEditingController();
  final _clientIdController = TextEditingController();
  final _printerIdController = TextEditingController();
  final _callingPersonController = TextEditingController();
  final _symptomController = TextEditingController();
  final _reportNotesController = TextEditingController();

  // Client
  final _refNoController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _telNoController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _personInChargeController = TextEditingController();
  final _printerSnController = TextEditingController();
  final _assignedEngineerController = TextEditingController();
  final _backupEngineerController = TextEditingController();

  // Visit
  final _visitDateController = TextEditingController();
  final _dispatchedController = TextEditingController();
  final _companyLeftController = TextEditingController();
  final _siteArrivalController = TextEditingController();
  final _serviceStartController = TextEditingController();
  final _serviceEndController = TextEditingController();
  final _siteLeftController = TextEditingController();
  final _companyBackController = TextEditingController();
  final _nextRefNoController = TextEditingController();

  // Fault & Action
  final _faultDescController = TextEditingController();
  final _faultCodeController = TextEditingController();
  final _actionDescController = TextEditingController();
  final _actionCodeController = TextEditingController();
  final _causeDescController = TextEditingController();
  final _causeCodeController = TextEditingController();
  final _responsibleDescController = TextEditingController();
  final _responsibleCodeController = TextEditingController();

  // Technical
  final _pNbController = TextEditingController();
  final _pAcController = TextEditingController();
  final _jet1Controller = TextEditingController();
  final _jet2Controller = TextEditingController();
  final _vacuumController = TextEditingController();
  final _vescoController = TextEditingController();
  final _tController = TextEditingController();
  final _workingHrController = TextEditingController();
  final _vmController = TextEditingController();
  final _swVersionController = TextEditingController();

  // Remarks & Signatures
  final _remarksController = TextEditingController();
  final _clientSignatureController = TextEditingController();
  final _engineerNameController = TextEditingController();
  final _reviewedByController = TextEditingController();
  final _authorizedByController = TextEditingController();
  final _dataEnteredByController = TextEditingController();
  final _formCodeController = TextEditingController();
  final _revCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate controllers with initial state
    final initialModel = context.read<JobOrderCubit>().state.jobOrder;
    _populateControllers(initialModel);
  }

  void _populateControllers(JobOrderModel m) {
    _jobNoController.text = m.jobOrderNo;
    _reportDateController.text = m.reportDate;
    _reportTimeController.text = m.reportTime;
    _clientIdController.text = m.clientId;
    _printerIdController.text = m.printerId;
    _callingPersonController.text = m.callingPerson;
    _symptomController.text = m.symptom;
    _reportNotesController.text = m.reportNotes;
    _refNoController.text = m.refNo;
    _clientNameController.text = m.clientName;
    _addressController.text = m.address;
    _telNoController.text = m.telNo;
    _mobileNoController.text = m.mobileNo;
    _personInChargeController.text = m.personInCharge;
    _printerSnController.text = m.printerSn;
    _assignedEngineerController.text = m.assignedEngineer;
    _backupEngineerController.text = m.backupEngineer;
    _visitDateController.text = m.visitDate;
    _dispatchedController.text = m.dispatched;
    _companyLeftController.text = m.companyLeftTime;
    _siteArrivalController.text = m.siteArrivalTime;
    _serviceStartController.text = m.serviceStartTime;
    _serviceEndController.text = m.serviceEndTime;
    _siteLeftController.text = m.siteLeftTime;
    _companyBackController.text = m.companyBackTime;
    _nextRefNoController.text = m.nextServiceReportRefNo;
    _faultDescController.text = m.faultDescription;
    _faultCodeController.text = m.faultCode;
    _actionDescController.text = m.actionDescription;
    _actionCodeController.text = m.actionCode;
    _causeDescController.text = m.causeDescription;
    _causeCodeController.text = m.causeCode;
    _responsibleDescController.text = m.responsibleDescription;
    _responsibleCodeController.text = m.responsibleCode;
    _pNbController.text = m.pNb;
    _pAcController.text = m.pAc;
    _jet1Controller.text = m.jet1;
    _jet2Controller.text = m.jet2;
    _vacuumController.text = m.vacuum;
    _vescoController.text = m.vesco;
    _tController.text = m.t;
    _workingHrController.text = m.workingHr;
    _vmController.text = m.vm;
    _swVersionController.text = m.swVersion;
    _remarksController.text = m.remarks;
    _clientSignatureController.text = m.clientSignature;
    _engineerNameController.text = m.engineerName;
    _reviewedByController.text = m.reviewedBy;
    _authorizedByController.text = m.authorizedBy;
    _dataEnteredByController.text = m.dataEnteredBy;
    _formCodeController.text = m.formCode;
    _revCodeController.text = m.revisionCode;
  }

  JobOrderModel _collectCurrentModel(JobOrderState state) {
    return state.jobOrder.copyWith(
      jobOrderNo: _jobNoController.text,
      reportDate: _reportDateController.text,
      reportTime: _reportTimeController.text,
      clientId: _clientIdController.text,
      printerId: _printerIdController.text,
      callingPerson: _callingPersonController.text,
      symptom: _symptomController.text,
      reportNotes: _reportNotesController.text,
      refNo: _refNoController.text,
      clientName: _clientNameController.text,
      address: _addressController.text,
      telNo: _telNoController.text,
      mobileNo: _mobileNoController.text,
      personInCharge: _personInChargeController.text,
      printerSn: _printerSnController.text,
      assignedEngineer: _assignedEngineerController.text,
      backupEngineer: _backupEngineerController.text,
      visitDate: _visitDateController.text,
      dispatched: _dispatchedController.text,
      companyLeftTime: _companyLeftController.text,
      siteArrivalTime: _siteArrivalController.text,
      serviceStartTime: _serviceStartController.text,
      serviceEndTime: _serviceEndController.text,
      siteLeftTime: _siteLeftController.text,
      companyBackTime: _companyBackController.text,
      nextServiceReportRefNo: _nextRefNoController.text,
      faultDescription: _faultDescController.text,
      faultCode: _faultCodeController.text,
      actionDescription: _actionDescController.text,
      actionCode: _actionCodeController.text,
      causeDescription: _causeDescController.text,
      causeCode: _causeCodeController.text,
      responsibleDescription: _responsibleDescController.text,
      responsibleCode: _responsibleCodeController.text,
      pNb: _pNbController.text,
      pAc: _pAcController.text,
      jet1: _jet1Controller.text,
      jet2: _jet2Controller.text,
      vacuum: _vacuumController.text,
      vesco: _vescoController.text,
      t: _tController.text,
      workingHr: _workingHrController.text,
      vm: _vmController.text,
      swVersion: _swVersionController.text,
      remarks: _remarksController.text,
      clientSignature: _clientSignatureController.text,
      engineerName: _engineerNameController.text,
      reviewedBy: _reviewedByController.text,
      authorizedBy: _authorizedByController.text,
      dataEnteredBy: _dataEnteredByController.text,
      formCode: _formCodeController.text,
      revisionCode: _revCodeController.text,
    );
  }

  @override
  void dispose() {
    _jobNoController.dispose();
    _reportDateController.dispose();
    _reportTimeController.dispose();
    _clientIdController.dispose();
    _printerIdController.dispose();
    _callingPersonController.dispose();
    _symptomController.dispose();
    _reportNotesController.dispose();
    _refNoController.dispose();
    _clientNameController.dispose();
    _addressController.dispose();
    _telNoController.dispose();
    _mobileNoController.dispose();
    _personInChargeController.dispose();
    _printerSnController.dispose();
    _assignedEngineerController.dispose();
    _backupEngineerController.dispose();
    _visitDateController.dispose();
    _dispatchedController.dispose();
    _companyLeftController.dispose();
    _siteArrivalController.dispose();
    _serviceStartController.dispose();
    _serviceEndController.dispose();
    _siteLeftController.dispose();
    _companyBackController.dispose();
    _nextRefNoController.dispose();
    _faultDescController.dispose();
    _faultCodeController.dispose();
    _actionDescController.dispose();
    _actionCodeController.dispose();
    _causeDescController.dispose();
    _causeCodeController.dispose();
    _responsibleDescController.dispose();
    _responsibleCodeController.dispose();
    _pNbController.dispose();
    _pAcController.dispose();
    _jet1Controller.dispose();
    _jet2Controller.dispose();
    _vacuumController.dispose();
    _vescoController.dispose();
    _tController.dispose();
    _workingHrController.dispose();
    _vmController.dispose();
    _swVersionController.dispose();
    _remarksController.dispose();
    _clientSignatureController.dispose();
    _engineerNameController.dispose();
    _reviewedByController.dispose();
    _authorizedByController.dispose();
    _dataEnteredByController.dispose();
    _formCodeController.dispose();
    _revCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobOrderCubit, JobOrderState>(
      listener: (context, state) {
        if (state.pdfStatus == JobOrderPdfStatus.success &&
            state.generatedPdfBytes != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobOrderPreviewScreen(
                pdfBytes: state.generatedPdfBytes!,
                model: state.jobOrder,
              ),
            ),
          );
        } else if (state.pdfStatus == JobOrderPdfStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<JobOrderCubit>();

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
                CustomText(
                  text: 'Job Order Form',
                  style: TextStyles.font18WhiteBold,
                ),
                Text(
                  'أمر شغل / تقرير صيانة - ألفا للإلكترونيات',
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                color: const Color(0xFF131F30),
                onSelected: (value) {
                  if (value == 'sample') {
                    cubit.loadSampleData();
                    _populateControllers(JobOrderModel.sample());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loaded sample data from reference PDF!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (value == 'clear') {
                    cubit.clearForm();
                    _populateControllers(const JobOrderModel());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form cleared!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'sample',
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, color: ColorManager.secondary, size: 18),
                        SizedBox(width: 8),
                        Text('Load Sample Data', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.clear_all, color: Colors.redAccent, size: 18),
                        SizedBox(width: 8),
                        Text('Clear Form', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 100.h),
                child: Column(
                  children: [
                    // Quick Action Helper Bar
                    Container(
                      margin: EdgeInsets.only(bottom: 14.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131F30),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFF22364F)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: ColorManager.primary, size: 18.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Form pre-filled with reference document data. Edit any field and tap Generate PDF.',
                              style: TextStyle(color: Colors.white70, fontSize: 11.5.sp),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: ColorManager.primary),
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            ),
                            onPressed: () {
                              cubit.loadSampleData();
                              _populateControllers(JobOrderModel.sample());
                            },
                            icon: const Icon(Icons.refresh, size: 14, color: ColorManager.primary),
                            label: const Text('Reset', style: TextStyle(color: ColorManager.primary, fontSize: 11)),
                          ),
                        ],
                      ),
                    ),

                    // Section 1: Job Header & Type
                    JobHeaderSectionWidget(
                      jobNoController: _jobNoController,
                      selectedJobType: state.jobOrder.selectedJobType,
                      onJobTypeSelected: cubit.selectJobType,
                    ),

                    // Section 2: Reporting & Client
                    ClientReportSectionWidget(
                      reportDateController: _reportDateController,
                      reportTimeController: _reportTimeController,
                      clientIdController: _clientIdController,
                      printerIdController: _printerIdController,
                      callingPersonController: _callingPersonController,
                      symptomController: _symptomController,
                      reportNotesController: _reportNotesController,
                      refNoController: _refNoController,
                      clientNameController: _clientNameController,
                      addressController: _addressController,
                      telNoController: _telNoController,
                      mobileNoController: _mobileNoController,
                      personInChargeController: _personInChargeController,
                      printerSnController: _printerSnController,
                      assignedEngineerController: _assignedEngineerController,
                      backupEngineerController: _backupEngineerController,
                    ),

                    // Section 3: Visit Information
                    VisitInfoSectionWidget(
                      selectedVisitType: state.jobOrder.visitType,
                      onVisitTypeSelected: cubit.selectVisitType,
                      visitDateController: _visitDateController,
                      dispatchedController: _dispatchedController,
                      companyLeftController: _companyLeftController,
                      siteArrivalController: _siteArrivalController,
                      serviceStartController: _serviceStartController,
                      serviceEndController: _serviceEndController,
                      siteLeftController: _siteLeftController,
                      companyBackController: _companyBackController,
                      returnToAlfaOrHome: state.jobOrder.returnToAlfaOrHome,
                      onReturnToAlfaChanged: (val) {
                        cubit.updateModel(state.jobOrder.copyWith(returnToAlfaOrHome: val));
                      },
                      proceedToAnotherCall: state.jobOrder.proceedToAnotherCall,
                      onProceedChanged: (val) {
                        cubit.updateModel(state.jobOrder.copyWith(proceedToAnotherCall: val));
                      },
                      nextRefNoController: _nextRefNoController,
                    ),

                    // Section 4: Faults & Actions
                    FaultActionSectionWidget(
                      faultDescController: _faultDescController,
                      faultCodeController: _faultCodeController,
                      actionDescController: _actionDescController,
                      actionCodeController: _actionCodeController,
                      causeDescController: _causeDescController,
                      causeCodeController: _causeCodeController,
                      responsibleDescController: _responsibleDescController,
                      responsibleCodeController: _responsibleCodeController,
                    ),

                    // Section 5: Technical & Spare Parts
                    TechnicalParamsSectionWidget(
                      pNbController: _pNbController,
                      pAcController: _pAcController,
                      jet1Controller: _jet1Controller,
                      jet2Controller: _jet2Controller,
                      vacuumController: _vacuumController,
                      vescoController: _vescoController,
                      tController: _tController,
                      workingHrController: _workingHrController,
                      vmController: _vmController,
                      swVersionController: _swVersionController,
                      selectedCondition: state.jobOrder.callCondition,
                      onConditionSelected: cubit.selectCallCondition,
                      spareParts: state.jobOrder.spareParts,
                      onAddSparePart: cubit.addSparePart,
                      onUpdateSparePart: cubit.updateSparePart,
                      onRemoveSparePart: cubit.removeSparePart,
                    ),

                    // Section 6: Remarks & Signatures
                    RemarksSignaturesWidget(
                      remarksController: _remarksController,
                      clientSignatureController: _clientSignatureController,
                      engineerNameController: _engineerNameController,
                      reviewedByController: _reviewedByController,
                      authorizedByController: _authorizedByController,
                      dataEnteredByController: _dataEnteredByController,
                      formCodeController: _formCodeController,
                      revCodeController: _revCodeController,
                    ),
                  ],
                ),
              ),

              // Bottom Action Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1624),
                    border: const Border(
                      top: BorderSide(color: Color(0xFF22364F), width: 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 2,
                    ),
                    onPressed: state.pdfStatus == JobOrderPdfStatus.loading
                        ? null
                        : () {
                            final currentModel = _collectCurrentModel(state);
                            cubit.updateModel(currentModel);
                            cubit.generatePdf();
                          },
                    icon: state.pdfStatus == JobOrderPdfStatus.loading
                        ? SizedBox(
                            width: 18.sp,
                            height: 18.sp,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: Text(
                      state.pdfStatus == JobOrderPdfStatus.loading
                          ? 'Generating PDF Document...'
                          : 'Generate & Preview PDF (إنشاء تقرير PDF)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
