import '../entities/maintenance_dashboard_entity.dart';
import '../entities/maintenance_ticket_entity.dart';
import '../entities/ticket_details_entity.dart';
import '../entities/assigned_ticket_filter.dart';
import '../entities/assigned_ticket_sort.dart';
import '../entities/ticket_resolution_entity.dart';
import '../entities/activity_history_item_entity.dart';

abstract class MaintenanceRepository {
  Future<MaintenanceDashboardEntity> getDashboard();
  
  Future<TicketDetailsEntity> getTicketDetails(String id);
  Future<void> updateTicketStatus(String id, String status);
  Future<void> addTicketNote(String id, String note, String authorName, String authorRole);
  
  // Ticket Operations
  Future<void> acceptTicket(String id);
  Future<void> startWork(String id);
  Future<void> pauseWork(String id);
  Future<void> resumeWork(String id);
  Future<void> escalateTicket(String id, String reason);
  Future<void> resolveTicket(String id, TicketResolutionEntity resolution);
  Future<void> saveResolutionDraft(String id, TicketResolutionEntity draft);
  Future<void> uploadResolutionPhotos(String id, List<String> photoPaths);
  Future<void> closeTicket(String id);

  Future<List<MaintenanceTicketEntity>> getAssignedTickets();
  
  Future<List<MaintenanceTicketEntity>> searchAssignedTickets({
    required String query,
    required List<MaintenanceTicketEntity> tickets,
  });

  Future<List<MaintenanceTicketEntity>> filterAssignedTickets({
    required Set<AssignedTicketFilter> filters,
    required List<MaintenanceTicketEntity> tickets,
  });

  Future<List<MaintenanceTicketEntity>> sortAssignedTickets({
    required AssignedTicketSort sort,
    required List<MaintenanceTicketEntity> tickets,
  });

  // ---- ACTIVITY HISTORY ----
  Future<List<ActivityHistoryItemEntity>> getActivityHistory();
  Future<List<ActivityHistoryItemEntity>> searchActivityHistory({
    required String query,
    required List<ActivityHistoryItemEntity> activities,
  });
  Future<List<ActivityHistoryItemEntity>> filterActivityHistory({
    required Set<AssignedTicketFilter> filters,
    required List<ActivityHistoryItemEntity> activities,
  });
}
