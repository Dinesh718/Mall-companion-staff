import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/accept_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/start_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/pause_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/resume_work_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/escalate_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/resolve_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/close_ticket_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/repositories/maintenance_repository.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/maintenance_dashboard_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/maintenance_ticket_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/ticket_details_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/assigned_ticket_filter.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/assigned_ticket_sort.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/ticket_resolution_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/activity_history_item_entity.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/save_resolution_draft_usecase.dart';
import 'package:mall_companion_staff/features/maintenance/domain/usecases/upload_resolution_photos_usecase.dart';

class MockRepo implements MaintenanceRepository {
  String lastCalledMethod = '';
  
  @override Future<void> acceptTicket(String id) async { lastCalledMethod = 'acceptTicket'; }
  @override Future<void> startWork(String id) async { lastCalledMethod = 'startWork'; }
  @override Future<void> pauseWork(String id) async { lastCalledMethod = 'pauseWork'; }
  @override Future<void> resumeWork(String id) async { lastCalledMethod = 'resumeWork'; }
  @override Future<void> escalateTicket(String id, String reason) async { lastCalledMethod = 'escalateTicket'; }
  @override Future<void> resolveTicket(String id, TicketResolutionEntity resolution) async { lastCalledMethod = 'resolveTicket'; }
  @override Future<void> saveResolutionDraft(String id, TicketResolutionEntity draft) async { lastCalledMethod = 'saveResolutionDraft'; }
  @override Future<void> uploadResolutionPhotos(String id, List<String> photoPaths) async { lastCalledMethod = 'uploadResolutionPhotos'; }
  @override Future<void> closeTicket(String id) async { lastCalledMethod = 'closeTicket'; }
  
  @override Future<void> updateTicketStatus(String id, String status) async {}
  @override Future<void> addTicketNote(String id, String note, String authorName, String authorRole) async {}
  
  // Unused mock methods for these tests
  @override Future<List<MaintenanceTicketEntity>> filterAssignedTickets({required Set<AssignedTicketFilter> filters, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> getAssignedTickets() => throw UnimplementedError();
  @override Future<MaintenanceDashboardEntity> getDashboard() => throw UnimplementedError();
  @override Future<TicketDetailsEntity> getTicketDetails(String id) => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> searchAssignedTickets({required String query, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();
  @override Future<List<MaintenanceTicketEntity>> sortAssignedTickets({required AssignedTicketSort sort, required List<MaintenanceTicketEntity> tickets}) => throw UnimplementedError();

  @override Future<List<ActivityHistoryItemEntity>> getActivityHistory() => throw UnimplementedError();
  @override Future<List<ActivityHistoryItemEntity>> searchActivityHistory({required String query, required List<ActivityHistoryItemEntity> activities}) => throw UnimplementedError();
  @override Future<List<ActivityHistoryItemEntity>> filterActivityHistory({required Set<AssignedTicketFilter> filters, required List<ActivityHistoryItemEntity> activities}) => throw UnimplementedError();
}

void main() {
  late MockRepo repository;

  setUp(() {
    repository = MockRepo();
  });

  test('AcceptTicketUseCase calls repository', () async {
    final usecase = AcceptTicketUseCase(repository: repository);
    await usecase('1');
    expect(repository.lastCalledMethod, 'acceptTicket');
  });

  test('StartWorkUseCase calls repository', () async {
    final usecase = StartWorkUseCase(repository: repository);
    await usecase('1');
    expect(repository.lastCalledMethod, 'startWork');
  });

  test('PauseWorkUseCase calls repository', () async {
    final usecase = PauseWorkUseCase(repository: repository);
    await usecase('1');
    expect(repository.lastCalledMethod, 'pauseWork');
  });

  test('ResumeWorkUseCase calls repository', () async {
    final usecase = ResumeWorkUseCase(repository: repository);
    await usecase('1');
    expect(repository.lastCalledMethod, 'resumeWork');
  });

  test('EscalateTicketUseCase calls repository', () async {
    final usecase = EscalateTicketUseCase(repository: repository);
    await usecase('1', 'reason');
    expect(repository.lastCalledMethod, 'escalateTicket');
  });

  test('ResolveTicketUseCase calls repository', () async {
    final usecase = ResolveTicketUseCase(repository: repository);
    await usecase('1', const TicketResolutionEntity(workPerformed: 'w', resolutionType: 'r'));
    expect(repository.lastCalledMethod, 'resolveTicket');
  });

  test('SaveResolutionDraftUseCase calls repository', () async {
    final usecase = SaveResolutionDraftUseCase(repository: repository);
    await usecase('1', const TicketResolutionEntity(workPerformed: 'w', resolutionType: 'r'));
    expect(repository.lastCalledMethod, 'saveResolutionDraft');
  });

  test('UploadResolutionPhotosUseCase calls repository', () async {
    final usecase = UploadResolutionPhotosUseCase(repository: repository);
    await usecase('1', ['path']);
    expect(repository.lastCalledMethod, 'uploadResolutionPhotos');
  });

  test('CloseTicketUseCase calls repository', () async {
    final usecase = CloseTicketUseCase(repository: repository);
    await usecase('1');
    expect(repository.lastCalledMethod, 'closeTicket');
  });
}
