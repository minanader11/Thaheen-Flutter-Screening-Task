import 'package:LJF_admin/features/admin/model/bank_certificate_model.dart';
import 'package:LJF_admin/features/admin/model/event_config_model.dart';
import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:equatable/equatable.dart';


enum AdminActionStatus { initial, loading, success, failure }

class AdminState extends Equatable {
  final List<TeamModel> teams;
  final List<TaskModel> dailyTasks;
  final List<TaskModel> bonusTasks;
  final List<TaskModel> flashTasks;

  final bool isLoading;
  final bool isConnected;
  final String errorMessage;

  // Per-action states
  final AdminActionStatus addPointsStatus;
  final AdminActionStatus createTaskStatus;
  final AdminActionStatus deleteTaskStatus;
  final AdminActionStatus activatePowerStatus;
  final AdminActionStatus deactivatePowerStatus;

  // ── New: Car progress ────────────────────────────────────
  final AdminActionStatus updateCarProgressStatus;

  // ── New: Bank ────────────────────────────────────────────
  final List<BankCertificateModel> bankCertificates;
  final AdminActionStatus loadBankCertificatesStatus;
  final AdminActionStatus createBankCertificateStatus;
  final AdminActionStatus deleteBankCertificateStatus;
  final AdminActionStatus updateBankBalanceStatus;

  // ── New: University ──────────────────────────────────────
  final int attendeeCount;
  final AdminActionStatus updateAttendeeCountStatus;

  // ── New: Event config ────────────────────────────────────
  final EventConfigModel? eventConfig;
  final AdminActionStatus loadEventConfigStatus;
  final AdminActionStatus updateEventConfigStatus;

  const AdminState({
    this.teams = const [],
    this.dailyTasks = const [],
    this.bonusTasks = const [],
    this.flashTasks = const [],
    this.isLoading = false,
    this.isConnected = false,
    this.errorMessage = '',
    this.addPointsStatus = AdminActionStatus.initial,
    this.createTaskStatus = AdminActionStatus.initial,
    this.deleteTaskStatus = AdminActionStatus.initial,
    this.activatePowerStatus = AdminActionStatus.initial,
    this.deactivatePowerStatus = AdminActionStatus.initial,
    this.updateCarProgressStatus = AdminActionStatus.initial,
    this.bankCertificates = const [],
    this.loadBankCertificatesStatus = AdminActionStatus.initial,
    this.createBankCertificateStatus = AdminActionStatus.initial,
    this.deleteBankCertificateStatus = AdminActionStatus.initial,
    this.updateBankBalanceStatus = AdminActionStatus.initial,
    this.attendeeCount = 0,
    this.updateAttendeeCountStatus = AdminActionStatus.initial,
    this.eventConfig,
    this.loadEventConfigStatus = AdminActionStatus.initial,
    this.updateEventConfigStatus = AdminActionStatus.initial,
  });

  AdminState copyWith({
    List<TeamModel>? teams,
    List<TaskModel>? dailyTasks,
    List<TaskModel>? bonusTasks,
    List<TaskModel>? flashTasks,
    bool? isLoading,
    bool? isConnected,
    String? errorMessage,
    AdminActionStatus? addPointsStatus,
    AdminActionStatus? createTaskStatus,
    AdminActionStatus? deleteTaskStatus,
    AdminActionStatus? activatePowerStatus,
    AdminActionStatus? deactivatePowerStatus,
    AdminActionStatus? updateCarProgressStatus,
    List<BankCertificateModel>? bankCertificates,
    AdminActionStatus? loadBankCertificatesStatus,
    AdminActionStatus? createBankCertificateStatus,
    AdminActionStatus? deleteBankCertificateStatus,
    AdminActionStatus? updateBankBalanceStatus,
    int? attendeeCount,
    AdminActionStatus? updateAttendeeCountStatus,
    EventConfigModel? eventConfig,
    AdminActionStatus? loadEventConfigStatus,
    AdminActionStatus? updateEventConfigStatus,
  }) {
    return AdminState(
      teams: teams ?? this.teams,
      dailyTasks: dailyTasks ?? this.dailyTasks,
      bonusTasks: bonusTasks ?? this.bonusTasks,
      flashTasks: flashTasks ?? this.flashTasks,
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: errorMessage ?? this.errorMessage,
      addPointsStatus: addPointsStatus ?? this.addPointsStatus,
      createTaskStatus: createTaskStatus ?? this.createTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      activatePowerStatus: activatePowerStatus ?? this.activatePowerStatus,
      deactivatePowerStatus:
      deactivatePowerStatus ?? this.deactivatePowerStatus,
      updateCarProgressStatus:
      updateCarProgressStatus ?? this.updateCarProgressStatus,
      bankCertificates: bankCertificates ?? this.bankCertificates,
      loadBankCertificatesStatus:
      loadBankCertificatesStatus ?? this.loadBankCertificatesStatus,
      createBankCertificateStatus:
      createBankCertificateStatus ?? this.createBankCertificateStatus,
      deleteBankCertificateStatus:
      deleteBankCertificateStatus ?? this.deleteBankCertificateStatus,
      updateBankBalanceStatus:
      updateBankBalanceStatus ?? this.updateBankBalanceStatus,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      updateAttendeeCountStatus:
      updateAttendeeCountStatus ?? this.updateAttendeeCountStatus,
      eventConfig: eventConfig ?? this.eventConfig,
      loadEventConfigStatus: loadEventConfigStatus ?? this.loadEventConfigStatus,
      updateEventConfigStatus:
      updateEventConfigStatus ?? this.updateEventConfigStatus,
    );
  }

  @override
  List<Object?> get props => [
    teams,
    dailyTasks,
    bonusTasks,
    flashTasks,
    isLoading,
    isConnected,
    errorMessage,
    addPointsStatus,
    createTaskStatus,
    deleteTaskStatus,
    activatePowerStatus,
    deactivatePowerStatus,
    updateCarProgressStatus,
    bankCertificates,
    loadBankCertificatesStatus,
    createBankCertificateStatus,
    deleteBankCertificateStatus,
    updateBankBalanceStatus,
    attendeeCount,
    updateAttendeeCountStatus,
    eventConfig,
    loadEventConfigStatus,
    updateEventConfigStatus,
  ];
}