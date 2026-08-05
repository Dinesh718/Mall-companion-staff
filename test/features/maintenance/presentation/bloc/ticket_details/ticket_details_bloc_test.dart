import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/maintenance/presentation/bloc/ticket_details/ticket_details_bloc.dart';
import 'package:mall_companion_staff/features/maintenance/presentation/bloc/ticket_details/ticket_details_event.dart';
import 'package:mall_companion_staff/features/maintenance/presentation/bloc/ticket_details/ticket_details_state.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/get_ticket_details_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/update_ticket_status_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/accept_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/start_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/pause_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/resume_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/escalate_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/resolve_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/close_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/ticket_details_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/ticket_resolution_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/maintenance_dashboard_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/maintenance_ticket_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/repositories/maintenance_repository.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/assigned_ticket_filter.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/assigned_ticket_sort.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/activity_history_item_entity.dart';

class MockRepo implements MaintenanceRepository {
  final TicketDetailsEntity dummyDetails = const TicketDetailsEntity(
    id: '1', title: 'T', description: 'D', status: 'S', priority: 'P', category: 'C', location: 'L', locationDetails: 'LD',
    sla: TicketSlaEntity(reportedTime: 'T', dueTime: 'T', timeRemaining: 'T'),
    timeline: [], attachments: [], notes: [],
  );

  @override Future<void> acceptTicket(String id) async {}
  @override Future<void> startWork(String id) async {}
  @override Future<void> pauseWork(String id) async {}
  @override Future<void> resumeWork(String id) async {}
  @override Future<void> escalateTicket(String id, String reason) async {}
  @override Future<void> resolveTicket(String id, TicketResolutionEntity resolution) async {}
  @override Future<void> saveResolutionDraft(String id, TicketResolutionEntity draft) async {}
  @override Future<void> uploadResolutionPhotos(String id, List<String> photoPaths) async {}
  @override Future<void> closeTicket(String id) async {}
  @override Future<void> updateTicketStatus(String id, String status) async {}
  @override Future<void> addTicketNote(String id, String note, String authorName, String authorRole) async {}
  @override Future<TicketDetailsEntity> getTicketDetails(String id) async => dummyDetails;
  
  @override Future<List<MaintenanceTicketEntity>> filterAssignedTickets({required Set<AssignedTicketFilter> filters, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> getAssignedTickets() => throw UnimplementedError();
  @override Future<MaintenanceDashboardEntity> getDashboard() => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> searchAssignedTickets({required String query, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> sortAssignedTickets({required AssignedTicketSort sort, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();

  @override Future<List<ActivityHistoryItemEntity>> getActivityHistory() => throw UnimplementedError();
  @override Future<List<ActivityHistoryItemEntity>> searchActivityHistory({required String query, required List<ActivityHistoryItemEntity> activities}) => throw UnimplementedError();
  @override Future<List<ActivityHistoryItemEntity>> filterActivityHistory({required Set<AssignedTicketFilter> filters, required List<ActivityHistoryItemEntity> activities}) => throw UnimplementedError();
}

void main() {
  late MockRepo repository;
  late TicketDetailsBloc bloc;

  setUp(() {
    repository = MockRepo();
    bloc = TicketDetailsBloc(
      getTicketDetailsUseCase: GetTicketDetailsUseCase(repository: repository),
      updateTicketStatusUseCase: UpdateTicketStatusUseCase(repository: repository),
      acceptTicketUseCase: AcceptTicketUseCase(repository: repository),
      startWorkUseCase: StartWorkUseCase(repository: repository),
      pauseWorkUseCase: PauseWorkUseCase(repository: repository),
      resumeWorkUseCase: ResumeWorkUseCase(repository: repository),
      escalateTicketUseCase: EscalateTicketUseCase(repository: repository),
      resolveTicketUseCase: ResolveTicketUseCase(repository: repository),
      closeTicketUseCase: CloseTicketUseCase(repository: repository),
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('PerformTicketOperation emits Loading then Success', () async {
    // First load
    bloc.add(const LoadTicketDetails('1'));
    await Future.delayed(const Duration(milliseconds: 50));
    
    // Perform operation
    bloc.add(const PerformTicketOperation(ticketId: '1', operation: TicketOperation.accept));
    
    // We expect loading then success
    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<TicketDetailsOperationLoading>(),
        isA<TicketDetailsOperationSuccess>(),
      ]),
    );
  });

  test('UpdateResolutionForm validates input', () async {
    bloc.add(const LoadTicketDetails('1'));
    await Future.delayed(const Duration(milliseconds: 50));

    bloc.add(const OpenResolutionWorkflow());
    await Future.delayed(const Duration(milliseconds: 10));
    expect((bloc.state as TicketResolutionFormState).isValid, false);

    bloc.add(const UpdateResolutionForm(
      workPerformed: 'Fixed it',
      resolutionType: 'Permanent',
      partsUsed: [],
      photos: [],
      internalNotes: '',
    ));
    await Future.delayed(const Duration(milliseconds: 10));
    expect((bloc.state as TicketResolutionFormState).isValid, true);
  });

  test('SubmitResolution with invalid form emits error in state', () async {
    bloc.add(const LoadTicketDetails('1'));
    await Future.delayed(const Duration(milliseconds: 50));
    
    bloc.add(const OpenResolutionWorkflow());
    await Future.delayed(const Duration(milliseconds: 10));
    
    bloc.add(const SubmitResolution('1'));
    await Future.delayed(const Duration(milliseconds: 10));
    
    final state = bloc.state as TicketResolutionFormState;
    expect(state.submissionError, isNotNull);
  });

  test('SubmitResolution with valid form emits success', () async {
    bloc.add(const LoadTicketDetails('1'));
    await Future.delayed(const Duration(milliseconds: 50));
    
    bloc.add(const OpenResolutionWorkflow());
    await Future.delayed(const Duration(milliseconds: 10));
    
    bloc.add(const UpdateResolutionForm(
      workPerformed: 'Fixed it',
      resolutionType: 'Permanent',
      partsUsed: [],
      photos: [],
      internalNotes: '',
    ));
    await Future.delayed(const Duration(milliseconds: 10));

    bloc.add(const SubmitResolution('1'));
    
    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<TicketResolutionFormState>(), // isSubmitting = true
        isA<TicketDetailsOperationSuccess>(),
      ]),
    );
  });
}
