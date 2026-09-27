import 'package:equatable/equatable.dart';

enum JobType {
  installation,
  reinstallation,
  pm,
  emergency,
  annualPm,
  other,
}

enum VisitType {
  atSite,
  byPhone,
  serviceCenter,
}

enum CallCondition {
  closed,
  followUp,
}

class SparePartItem extends Equatable {
  final String description;
  final String quantity;
  final String unitPrice;
  final String discount;
  final String warranty;
  final bool isClient;
  final bool isAlfa;

  const SparePartItem({
    this.description = '',
    this.quantity = '',
    this.unitPrice = '',
    this.discount = '',
    this.warranty = '',
    this.isClient = false,
    this.isAlfa = false,
  });

  SparePartItem copyWith({
    String? description,
    String? quantity,
    String? unitPrice,
    String? discount,
    String? warranty,
    bool? isClient,
    bool? isAlfa,
  }) {
    return SparePartItem(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      warranty: warranty ?? this.warranty,
      isClient: isClient ?? this.isClient,
      isAlfa: isAlfa ?? this.isAlfa,
    );
  }

  @override
  List<Object?> get props => [
        description,
        quantity,
        unitPrice,
        discount,
        warranty,
        isClient,
        isAlfa,
      ];
}

class JobOrderModel extends Equatable {
  // Header
  final String jobOrderNo;
  final JobType selectedJobType;

  // Report Section (Left)
  final String reportDate;
  final String reportTime;
  final String clientId;
  final String printerId;
  final String callingPerson;
  final String symptom;
  final String reportNotes;

  // Client Info Section (Right)
  final String refNo;
  final String clientName;
  final String address;
  final String telNo;
  final String mobileNo;
  final String personInCharge;
  final String printerSn;
  final String assignedEngineer;
  final String backupEngineer;
  final String maintenanceType;

  // Visit Information
  final VisitType visitType;
  final String visitDate;
  final String dispatched;
  final String companyLeftTime;
  final String siteArrivalTime;
  final String serviceStartTime;
  final String serviceEndTime;
  final String siteLeftTime;
  final String companyBackTime;
  final bool returnToAlfaOrHome;
  final bool proceedToAnotherCall;
  final String nextServiceReportRefNo;

  // Faults & Actions
  final String faultDescription;
  final String faultCode;
  final String actionDescription;
  final String actionCode;
  final String causeDescription;
  final String causeCode;
  final String responsibleDescription;
  final String responsibleCode;

  // Technical Parameters
  final String pNb;
  final String pAc;
  final String jet1;
  final String jet2;
  final String vacuum;
  final String vesco;
  final String t;
  final String workingHr;
  final String vm;
  final String swVersion;
  final CallCondition callCondition;

  // Spare Parts
  final List<SparePartItem> spareParts;

  // Remarks
  final String remarks;

  // Signatures
  final String clientSignature;
  final String engineerName;
  final String reviewedBy;
  final String authorizedBy;
  final String dataEnteredBy;

  // Form Version Codes
  final String formCode;
  final String revisionCode;

  const JobOrderModel({
    this.jobOrderNo = '',
    this.selectedJobType = JobType.emergency,
    this.reportDate = '',
    this.reportTime = '',
    this.clientId = '',
    this.printerId = '',
    this.callingPerson = '',
    this.symptom = '',
    this.reportNotes = '',
    this.refNo = '',
    this.clientName = '',
    this.address = '',
    this.telNo = '',
    this.mobileNo = '',
    this.personInCharge = '',
    this.printerSn = '',
    this.assignedEngineer = '',
    this.backupEngineer = '',
    this.maintenanceType = '',
    this.visitType = VisitType.atSite,
    this.visitDate = '',
    this.dispatched = '',
    this.companyLeftTime = '',
    this.siteArrivalTime = '',
    this.serviceStartTime = '',
    this.serviceEndTime = '',
    this.siteLeftTime = '',
    this.companyBackTime = '',
    this.returnToAlfaOrHome = false,
    this.proceedToAnotherCall = false,
    this.nextServiceReportRefNo = '',
    this.faultDescription = '',
    this.faultCode = '',
    this.actionDescription = '',
    this.actionCode = '',
    this.causeDescription = '',
    this.causeCode = '',
    this.responsibleDescription = '',
    this.responsibleCode = '',
    this.pNb = '',
    this.pAc = '',
    this.jet1 = '',
    this.jet2 = '',
    this.vacuum = '',
    this.vesco = '',
    this.t = '',
    this.workingHr = '',
    this.vm = '',
    this.swVersion = '',
    this.callCondition = CallCondition.closed,
    this.spareParts = const [],
    this.remarks = '',
    this.clientSignature = '',
    this.engineerName = '',
    this.reviewedBy = '',
    this.authorizedBy = '',
    this.dataEnteredBy = '',
    this.formCode = 'F-04-08',
    this.revisionCode = 'Rev1',
  });

  /// Returns sample data matching the exact Job Order document provided in the reference image
  factory JobOrderModel.sample() {
    return const JobOrderModel(
      jobOrderNo: '9029',
      selectedJobType: JobType.emergency,
      reportDate: '16/09/2026',
      reportTime: '13:08',
      clientId: '',
      printerId: '',
      callingPerson: '',
      symptom: '85, vacuum pump failure',
      reportNotes: 'سيتم ارسال عرض سعر بقطعة الغيار المطلوبه',
      refNo: '',
      clientName: 'Top Chemical',
      address: 'Borg El-Arab',
      telNo: '',
      mobileNo: '',
      personInCharge: '',
      printerSn: 'FR19480143',
      assignedEngineer: 'Karam',
      backupEngineer: '',
      maintenanceType: '',
      visitType: VisitType.atSite,
      visitDate: '16 / 09 / 2026',
      dispatched: '',
      companyLeftTime: '',
      siteArrivalTime: '13:08',
      serviceStartTime: '13:08',
      serviceEndTime: '13:08',
      siteLeftTime: '13:08',
      companyBackTime: '13:08',
      returnToAlfaOrHome: false,
      proceedToAnotherCall: false,
      nextServiceReportRefNo: '',
      faultDescription: '85, vacuum pump failure',
      faultCode: '',
      actionDescription:
          'تم تنظيف مضخة الشفط وتم تسليك مسار الشفط والماكينة تعمل الان ولكنها بحاجه الي تغيير 6M module',
      actionCode: '',
      causeDescription: '',
      causeCode: '',
      responsibleDescription: '',
      responsibleCode: '',
      pNb: '',
      pAc: '',
      jet1: '',
      jet2: '',
      vacuum: '',
      vesco: '',
      t: '',
      workingHr: '',
      vm: '',
      swVersion: '',
      callCondition: CallCondition.closed,
      spareParts: [
        SparePartItem(
          description: '',
          quantity: '',
          unitPrice: '',
          discount: '',
          warranty: '',
          isClient: false,
          isAlfa: false,
        ),
      ],
      remarks: 'سيتم ارسال عرض سعر بقطعة الغيار المطلوبه',
      clientSignature: '',
      engineerName: 'Karam',
      reviewedBy: '',
      authorizedBy: '',
      dataEnteredBy: '',
      formCode: 'F-04-08',
      revisionCode: 'Rev1',
    );
  }

  JobOrderModel copyWith({
    String? jobOrderNo,
    JobType? selectedJobType,
    String? reportDate,
    String? reportTime,
    String? clientId,
    String? printerId,
    String? callingPerson,
    String? symptom,
    String? reportNotes,
    String? refNo,
    String? clientName,
    String? address,
    String? telNo,
    String? mobileNo,
    String? personInCharge,
    String? printerSn,
    String? assignedEngineer,
    String? backupEngineer,
    String? maintenanceType,
    VisitType? visitType,
    String? visitDate,
    String? dispatched,
    String? companyLeftTime,
    String? siteArrivalTime,
    String? serviceStartTime,
    String? serviceEndTime,
    String? siteLeftTime,
    String? companyBackTime,
    bool? returnToAlfaOrHome,
    bool? proceedToAnotherCall,
    String? nextServiceReportRefNo,
    String? faultDescription,
    String? faultCode,
    String? actionDescription,
    String? actionCode,
    String? causeDescription,
    String? causeCode,
    String? responsibleDescription,
    String? responsibleCode,
    String? pNb,
    String? pAc,
    String? jet1,
    String? jet2,
    String? vacuum,
    String? vesco,
    String? t,
    String? workingHr,
    String? vm,
    String? swVersion,
    CallCondition? callCondition,
    List<SparePartItem>? spareParts,
    String? remarks,
    String? clientSignature,
    String? engineerName,
    String? reviewedBy,
    String? authorizedBy,
    String? dataEnteredBy,
    String? formCode,
    String? revisionCode,
  }) {
    return JobOrderModel(
      jobOrderNo: jobOrderNo ?? this.jobOrderNo,
      selectedJobType: selectedJobType ?? this.selectedJobType,
      reportDate: reportDate ?? this.reportDate,
      reportTime: reportTime ?? this.reportTime,
      clientId: clientId ?? this.clientId,
      printerId: printerId ?? this.printerId,
      callingPerson: callingPerson ?? this.callingPerson,
      symptom: symptom ?? this.symptom,
      reportNotes: reportNotes ?? this.reportNotes,
      refNo: refNo ?? this.refNo,
      clientName: clientName ?? this.clientName,
      address: address ?? this.address,
      telNo: telNo ?? this.telNo,
      mobileNo: mobileNo ?? this.mobileNo,
      personInCharge: personInCharge ?? this.personInCharge,
      printerSn: printerSn ?? this.printerSn,
      assignedEngineer: assignedEngineer ?? this.assignedEngineer,
      backupEngineer: backupEngineer ?? this.backupEngineer,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      visitType: visitType ?? this.visitType,
      visitDate: visitDate ?? this.visitDate,
      dispatched: dispatched ?? this.dispatched,
      companyLeftTime: companyLeftTime ?? this.companyLeftTime,
      siteArrivalTime: siteArrivalTime ?? this.siteArrivalTime,
      serviceStartTime: serviceStartTime ?? this.serviceStartTime,
      serviceEndTime: serviceEndTime ?? this.serviceEndTime,
      siteLeftTime: siteLeftTime ?? this.siteLeftTime,
      companyBackTime: companyBackTime ?? this.companyBackTime,
      returnToAlfaOrHome: returnToAlfaOrHome ?? this.returnToAlfaOrHome,
      proceedToAnotherCall: proceedToAnotherCall ?? this.proceedToAnotherCall,
      nextServiceReportRefNo:
          nextServiceReportRefNo ?? this.nextServiceReportRefNo,
      faultDescription: faultDescription ?? this.faultDescription,
      faultCode: faultCode ?? this.faultCode,
      actionDescription: actionDescription ?? this.actionDescription,
      actionCode: actionCode ?? this.actionCode,
      causeDescription: causeDescription ?? this.causeDescription,
      causeCode: causeCode ?? this.causeCode,
      responsibleDescription:
          responsibleDescription ?? this.responsibleDescription,
      responsibleCode: responsibleCode ?? this.responsibleCode,
      pNb: pNb ?? this.pNb,
      pAc: pAc ?? this.pAc,
      jet1: jet1 ?? this.jet1,
      jet2: jet2 ?? this.jet2,
      vacuum: vacuum ?? this.vacuum,
      vesco: vesco ?? this.vesco,
      t: t ?? this.t,
      workingHr: workingHr ?? this.workingHr,
      vm: vm ?? this.vm,
      swVersion: swVersion ?? this.swVersion,
      callCondition: callCondition ?? this.callCondition,
      spareParts: spareParts ?? this.spareParts,
      remarks: remarks ?? this.remarks,
      clientSignature: clientSignature ?? this.clientSignature,
      engineerName: engineerName ?? this.engineerName,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      authorizedBy: authorizedBy ?? this.authorizedBy,
      dataEnteredBy: dataEnteredBy ?? this.dataEnteredBy,
      formCode: formCode ?? this.formCode,
      revisionCode: revisionCode ?? this.revisionCode,
    );
  }

  @override
  List<Object?> get props => [
        jobOrderNo,
        selectedJobType,
        reportDate,
        reportTime,
        clientId,
        printerId,
        callingPerson,
        symptom,
        reportNotes,
        refNo,
        clientName,
        address,
        telNo,
        mobileNo,
        personInCharge,
        printerSn,
        assignedEngineer,
        backupEngineer,
        maintenanceType,
        visitType,
        visitDate,
        dispatched,
        companyLeftTime,
        siteArrivalTime,
        serviceStartTime,
        serviceEndTime,
        siteLeftTime,
        companyBackTime,
        returnToAlfaOrHome,
        proceedToAnotherCall,
        nextServiceReportRefNo,
        faultDescription,
        faultCode,
        actionDescription,
        actionCode,
        causeDescription,
        causeCode,
        responsibleDescription,
        responsibleCode,
        pNb,
        pAc,
        jet1,
        jet2,
        vacuum,
        vesco,
        t,
        workingHr,
        vm,
        swVersion,
        callCondition,
        spareParts,
        remarks,
        clientSignature,
        engineerName,
        reviewedBy,
        authorizedBy,
        dataEnteredBy,
        formCode,
        revisionCode,
      ];
}
