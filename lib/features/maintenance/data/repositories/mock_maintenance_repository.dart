import '../../domain/entities/maintenance_dashboard_entity.dart';
import '../../domain/entities/maintenance_ticket_entity.dart';
import '../../domain/entities/maintenance_activity_entity.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../../domain/entities/ticket_details_entity.dart';
import '../../domain/entities/assigned_ticket_filter.dart';
import '../../domain/entities/assigned_ticket_sort.dart';
import '../../domain/entities/ticket_resolution_entity.dart';
import '../../domain/entities/activity_history_item_entity.dart';
import '../../../reservation/domain/entities/timeline_event_entity.dart';

class MockMaintenanceRepository implements MaintenanceRepository {
  // Mock Data Storage
  final Map<String, TicketDetailsEntity> _ticketDetails = {
    '#MT-2045': const TicketDetailsEntity(
      id: '#MT-2045',
      title: 'HVAC Leak Repair',
      description: 'The main HVAC unit on Level 2 is leaking water near the food court entrance. Needs immediate inspection to prevent slip hazards and floor damage.',
      status: 'In Progress',
      priority: 'Critical',
      category: 'HVAC',
      location: 'Level 2 - Food Court',
      locationDetails: 'Near Food Court Entrance A',
      sla: TicketSlaEntity(
        reportedTime: '08:30 AM',
        dueTime: '12:30 PM',
        timeRemaining: '1h 15m',
        isBreached: false,
      ),
      timeline: [
        TimelineEventEntity(
          title: 'Started Work',
          subtitle: 'Today, 09:30 AM',
          isPrimary: true,
          isPast: true,
        ),
        TimelineEventEntity(
          title: 'Ticket Accepted',
          subtitle: 'Today, 09:15 AM',
          isPrimary: false,
          isPast: true,
        ),
        TimelineEventEntity(
          title: 'Ticket Assigned to Alex',
          subtitle: 'Today, 09:00 AM',
          isPrimary: false,
          isPast: true,
        ),
        TimelineEventEntity(
          title: 'Ticket Created',
          subtitle: 'Today, 08:30 AM',
          isPrimary: false,
          isPast: true,
        ),
      ],
      attachments: [
        TicketAttachmentEntity(id: 'a1', name: 'water_leak_1.jpg', url: 'https://via.placeholder.com/150', type: 'image', size: '2.4 MB'),
        TicketAttachmentEntity(id: 'a2', name: 'hvac_schematic.pdf', url: 'https://via.placeholder.com/150', type: 'document', size: '1.1 MB'),
      ],
      notes: [
        TicketNoteEntity(id: 'n1', authorName: 'Sarah Jenkins', authorRole: 'Facility Manager', content: 'Please check the condensation line first.', timestamp: '09:00 AM'),
      ],
    ),
    '#MT-2049': const TicketDetailsEntity(
      id: '#MT-2049',
      title: 'Lighting Malfunction',
      description: 'Multiple lights are flickering or out entirely in Basement Parking A. Creates a safety hazard for patrons.',
      status: 'Assigned',
      priority: 'High',
      category: 'Electrical',
      location: 'Basement - Parking A',
      locationDetails: 'Near row G4',
      sla: TicketSlaEntity(
        reportedTime: '09:15 AM',
        dueTime: '01:15 PM',
        timeRemaining: '3h 45m',
        isBreached: false,
      ),
      timeline: [
        TimelineEventEntity(title: 'Ticket Assigned to Alex', subtitle: 'Today, 09:30 AM', isPrimary: true, isPast: true),
        TimelineEventEntity(title: 'Ticket Created', subtitle: 'Today, 09:15 AM', isPrimary: false, isPast: true),
      ],
      attachments: [],
      notes: [],
    ),
    '#MT-2051': const TicketDetailsEntity(
      id: '#MT-2051',
      title: 'Restroom Plumbing Issue',
      description: 'Sink 3 is overflowing continuously in the Level 1 Men\'s Restroom.',
      status: 'Assigned',
      priority: 'Medium',
      category: 'Plumbing',
      location: 'Level 1 - Near Entrance',
      locationDetails: 'Men\'s Restroom',
      sla: TicketSlaEntity(reportedTime: '10:00 AM', dueTime: '04:00 PM', timeRemaining: '6h 00m', isBreached: false),
      timeline: [
        TimelineEventEntity(title: 'Ticket Created', subtitle: 'Today, 10:00 AM', isPrimary: true, isPast: true),
      ],
      attachments: [],
      notes: [],
    ),
  };

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    final min = now.minute.toString().padLeft(2, '0');
    final hr = hour.toString().padLeft(2, '0');
    return '$hr:$min $amPm';
  }

  void _addTimelineEvent(String id, String title) {
    if (!_ticketDetails.containsKey(id)) return;
    
    final currentTicket = _ticketDetails[id]!;
    final newEvent = TimelineEventEntity(
      title: title,
      subtitle: 'Today, ${_formatCurrentTime()}',
      isPrimary: true,
      isPast: true,
    );
    
    // Demote old primary events
    final updatedTimeline = currentTicket.timeline.map((e) {
      if (e.isPrimary) {
        return TimelineEventEntity(title: e.title, subtitle: e.subtitle, isPrimary: false, isPast: true);
      }
      return e;
    }).toList();
    
    updatedTimeline.insert(0, newEvent);
    
    _ticketDetails[id] = currentTicket.copyWith(timeline: updatedTimeline);
  }

  void _updateStatus(String id, String status, String timelineTitle) {
    if (!_ticketDetails.containsKey(id)) return;
    
    final currentTicket = _ticketDetails[id]!;
    
    // Validate basic state machine rules loosely matching the requirement
    final validTransitions = {
      'Assigned': ['Accepted', 'Escalated'],
      'Accepted': ['In Progress', 'Escalated'],
      'In Progress': ['Paused', 'Resolved', 'Escalated'],
      'Paused': ['In Progress', 'Escalated'],
      'Resolved': ['Closed'],
      'Closed': [],
      'Escalated': [],
    };

    final currentStatus = currentTicket.status;
    if (!validTransitions.containsKey(currentStatus) || !validTransitions[currentStatus]!.contains(status)) {
      throw Exception('Invalid status transition from $currentStatus to $status');
    }

    _ticketDetails[id] = currentTicket.copyWith(status: status);
    _addTimelineEvent(id, timelineTitle);
  }

  // ---- NEW OPERATIONS ----
  @override
  Future<void> acceptTicket(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'Accepted', 'Ticket Accepted');
  }

  @override
  Future<void> startWork(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'In Progress', 'Started Work');
  }

  @override
  Future<void> pauseWork(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'Paused', 'Work Paused');
  }

  @override
  Future<void> resumeWork(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'In Progress', 'Work Resumed');
  }

  @override
  Future<void> escalateTicket(String id, String reason) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'Escalated', 'Ticket Escalated: $reason');
  }

  @override
  Future<void> resolveTicket(String id, TicketResolutionEntity resolution) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'Resolved', 'Ticket Resolved');
    
    // Add work performed as a note
    await addTicketNote(id, 'Resolution [${resolution.resolutionType}]: ${resolution.workPerformed}', 'Alex', 'Technician');
    if (resolution.internalNotes.isNotEmpty) {
      await addTicketNote(id, 'Internal Note: ${resolution.internalNotes}', 'Alex', 'Technician');
    }
  }

  @override
  Future<void> saveResolutionDraft(String id, TicketResolutionEntity draft) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Simulating saving draft - in a real app, we'd store this
  }

  @override
  Future<void> uploadResolutionPhotos(String id, List<String> photoPaths) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Simulating upload
  }

  @override
  Future<void> closeTicket(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _updateStatus(id, 'Closed', 'Ticket Closed');
  }
  // ------------------------

  List<MaintenanceTicketEntity> get _assignedTicketsList {
    return _ticketDetails.values.map((details) {
      return MaintenanceTicketEntity(
        id: details.id,
        title: details.title,
        location: details.location,
        status: details.status,
        priority: details.priority,
        reportedTime: details.sla.reportedTime,
        category: details.category,
      );
    }).toList();
  }

  @override
  Future<MaintenanceDashboardEntity> getDashboard() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return MaintenanceDashboardEntity(
      staffName: 'Alex',
      staffRole: 'Maintenance',
      assignedCount: 12,
      priorityCount: 4,
      inProgressCount: 2,
      completedCount: 6,
      resolvedToday: 6,
      avgResolutionMins: 42,
      slaCompliancePercent: 98,
      pendingTasks: 4,
      assignedTickets: _assignedTicketsList,
      recentActivity: const [
        MaintenanceActivityEntity(id: '1', title: 'Resolved Lighting Issue', subtitle: '#MT-1842 • 15 mins ago', type: 'resolved'),
        MaintenanceActivityEntity(id: '2', title: 'Started Electrical Repair', subtitle: '#MT-1988 • 1 hour ago', type: 'started'),
      ],
    );
  }

  @override
  Future<List<MaintenanceTicketEntity>> getAssignedTickets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _assignedTicketsList;
  }

  @override
  Future<List<MaintenanceTicketEntity>> searchAssignedTickets({
    required String query,
    required List<MaintenanceTicketEntity> tickets,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowerQuery = query.trim().toLowerCase();
    if (lowerQuery.isEmpty) return tickets;
    
    return tickets.where((ticket) {
      return ticket.id.toLowerCase().contains(lowerQuery) ||
          ticket.title.toLowerCase().contains(lowerQuery) ||
          ticket.category.toLowerCase().contains(lowerQuery) ||
          ticket.location.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<MaintenanceTicketEntity>> filterAssignedTickets({
    required Set<AssignedTicketFilter> filters,
    required List<MaintenanceTicketEntity> tickets,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (filters.isEmpty || filters.contains(AssignedTicketFilter.all)) return tickets;
    
    final statuses = filters.where((f) => f.name.startsWith('status')).toList();
    final priorities = filters.where((f) => f.name.startsWith('priority')).toList();
    final categories = filters.where((f) => f.name.startsWith('category')).toList();
    final floors = filters.where((f) => f.name.startsWith('floor')).toList();
    final times = filters.where((f) => f.name.startsWith('time')).toList();

    return tickets.where((t) {
      bool matchStatus = statuses.isEmpty;
      if (!matchStatus) {
        final tStatus = t.status.toLowerCase().replaceAll(' ', '');
        matchStatus = statuses.any((f) => f.name.toLowerCase().endsWith(tStatus));
      }

      bool matchPriority = priorities.isEmpty;
      if (!matchPriority) {
        final tPriority = t.priority.toLowerCase();
        matchPriority = priorities.any((f) => f.name.toLowerCase().endsWith(tPriority));
      }

      bool matchCategory = categories.isEmpty;
      if (!matchCategory) {
        final tCategory = t.category.toLowerCase().replaceAll(' ', '');
        matchCategory = categories.any((f) {
           final fName = f.name.toLowerCase();
           return fName.endsWith(tCategory) || (fName.endsWith('general') && tCategory.contains('general'));
        });
      }

      bool matchFloor = floors.isEmpty;
      if (!matchFloor) {
        final tLocation = t.location.toLowerCase();
        matchFloor = floors.any((f) {
          final floorName = f.name.replaceAll('floor', '').toLowerCase();
          return tLocation.contains(floorName);
        });
      }

      bool matchTime = times.isEmpty;
      if (!matchTime) {
        // Mock time logic: since this is mock data, we just assume matches if they want Today (as mock tickets are today)
        matchTime = times.any((f) => f == AssignedTicketFilter.timeToday);
      }

      return matchStatus && matchPriority && matchCategory && matchFloor && matchTime;
    }).toList();
  }

  @override
  Future<List<MaintenanceTicketEntity>> sortAssignedTickets({
    required AssignedTicketSort sort,
    required List<MaintenanceTicketEntity> tickets,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sorted = List<MaintenanceTicketEntity>.from(tickets);
    switch (sort) {
      case AssignedTicketSort.newest:
        sorted.sort((a, b) => b.id.compareTo(a.id));
        break;
      case AssignedTicketSort.oldest:
        sorted.sort((a, b) => a.id.compareTo(b.id));
        break;
      case AssignedTicketSort.highestPriority:
        int priorityValue(String p) {
          final lp = p.toLowerCase();
          if (lp == 'critical') return 4;
          if (lp == 'high') return 3;
          if (lp == 'medium') return 2;
          return 1;
        }
        sorted.sort((a, b) => priorityValue(b.priority).compareTo(priorityValue(a.priority)));
        break;
      case AssignedTicketSort.recentlyUpdated:
        sorted.sort((a, b) => b.id.compareTo(a.id)); // Mock recent
        break;
      case AssignedTicketSort.dueSoon:
        sorted.sort((a, b) => a.id.compareTo(b.id)); // Mock due soon
        break;
    }
    return sorted;
  }

  @override
  Future<TicketDetailsEntity> getTicketDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_ticketDetails.containsKey(id)) {
      return _ticketDetails[id]!;
    }
    throw Exception('Ticket not found');
  }

  @override
  Future<void> updateTicketStatus(String id, String status) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _updateStatus(id, status, 'Status Updated to $status');
  }

  @override
  Future<void> addTicketNote(String id, String note, String authorName, String authorRole) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!_ticketDetails.containsKey(id)) return;
    final ticket = _ticketDetails[id]!;
    final newNote = TicketNoteEntity(
      id: 'n${DateTime.now().millisecondsSinceEpoch}',
      authorName: authorName,
      authorRole: authorRole,
      content: note,
      timestamp: _formatCurrentTime(),
    );
    final updatedNotes = List<TicketNoteEntity>.from(ticket.notes)..insert(0, newNote);
    _ticketDetails[id] = ticket.copyWith(notes: updatedNotes);
    _addTimelineEvent(id, 'Note Added by $authorName');
  }

  // ---- ACTIVITY HISTORY ----
  @override
  Future<List<ActivityHistoryItemEntity>> getActivityHistory() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const [
      // Today
      ActivityHistoryItemEntity(
        id: 'act1',
        title: 'Resolved HVAC Leak',
        time: '14:20',
        ticketId: '#MT-2045',
        priority: 'High Priority',
        status: 'Completed',
        location: 'North Wing, Level 2, Near Zara',
        metadataText: 'Assigned by: Tech Team A',
        metadataIcon: 'person',
        iconType: 'check_circle',
        dateGroup: 'Today • June 12',
        category: 'HVAC',
      ),
      ActivityHistoryItemEntity(
        id: 'act2',
        title: 'Started Elevator Inspection',
        time: '09:15',
        ticketId: '#MT-2102',
        priority: 'Routine',
        status: 'In Progress',
        location: 'Main Atrium, Elevators 3 & 4',
        metadataText: 'Duration: 45m',
        metadataIcon: 'schedule',
        iconType: 'play_arrow',
        dateGroup: 'Today • June 12',
        category: 'Escalator',
      ),
      ActivityHistoryItemEntity(
        id: 'act3',
        title: 'Accepted Lighting Repair',
        time: '08:00',
        ticketId: '#MT-2098',
        priority: 'Medium',
        status: 'Assigned',
        location: 'Parking P1, Row G',
        metadataText: 'Assigned by: Tech Team B',
        metadataIcon: 'person',
        iconType: 'assignment_turned_in',
        dateGroup: 'Today • June 12',
        category: 'Lighting',
      ),
      // Yesterday
      ActivityHistoryItemEntity(
        id: 'act4',
        title: 'Paused Pipe Maintenance',
        time: '17:45',
        ticketId: '#MT-1980',
        priority: 'Part Pending',
        status: 'On Hold',
        location: 'Food Court, Service Room B',
        metadataText: 'Duration: 2h 15m',
        metadataIcon: 'history',
        iconType: 'pause_circle',
        dateGroup: 'Yesterday • June 11',
        category: 'Plumbing',
      ),
    ];
  }

  @override
  Future<List<ActivityHistoryItemEntity>> searchActivityHistory({
    required String query,
    required List<ActivityHistoryItemEntity> activities,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowerQuery = query.trim().toLowerCase();
    if (lowerQuery.isEmpty) return activities;
    
    return activities.where((act) {
      return act.ticketId.toLowerCase().contains(lowerQuery) ||
          act.title.toLowerCase().contains(lowerQuery) ||
          act.location.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<ActivityHistoryItemEntity>> filterActivityHistory({
    required Set<AssignedTicketFilter> filters,
    required List<ActivityHistoryItemEntity> activities,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (filters.isEmpty || filters.contains(AssignedTicketFilter.all)) return activities;
    
    final statuses = filters.where((f) => f.name.startsWith('status')).toList();
    final priorities = filters.where((f) => f.name.startsWith('priority')).toList();
    final categories = filters.where((f) => f.name.startsWith('category')).toList();
    final floors = filters.where((f) => f.name.startsWith('floor')).toList();
    final times = filters.where((f) => f.name.startsWith('time')).toList();

    return activities.where((act) {
      bool matchStatus = statuses.isEmpty;
      if (!matchStatus) {
        // Map UI filter status to Mock data status
        // UI filters: statusAssigned, statusAccepted, statusInProgress, statusPaused, statusEscalated, statusResolved, statusClosed
        // Mock data status: 'Completed', 'In Progress', 'Assigned', 'On Hold'
        final actStatus = act.status.toLowerCase().replaceAll(' ', '');
        matchStatus = statuses.any((f) {
          final fName = f.name.toLowerCase();
          if (fName.endsWith('resolved') && actStatus == 'completed') return true;
          if (fName.endsWith('paused') && actStatus == 'onhold') return true;
          return fName.endsWith(actStatus);
        });
      }

      bool matchPriority = priorities.isEmpty;
      if (!matchPriority) {
        final actPriority = act.priority.toLowerCase();
        matchPriority = priorities.any((f) => f.name.toLowerCase().endsWith(actPriority));
      }

      bool matchCategory = categories.isEmpty;
      if (!matchCategory) {
        final actCategory = act.category.toLowerCase().replaceAll(' ', '');
        matchCategory = categories.any((f) {
           final fName = f.name.toLowerCase();
           return fName.endsWith(actCategory) || (fName.endsWith('general') && actCategory.contains('general'));
        });
      }

      bool matchFloor = floors.isEmpty;
      if (!matchFloor) {
        final actLocation = act.location.toLowerCase();
        matchFloor = floors.any((f) {
          final floorName = f.name.replaceAll('floor', '').toLowerCase();
          return actLocation.contains(floorName);
        });
      }

      bool matchTime = times.isEmpty;
      if (!matchTime) {
        final isToday = act.dateGroup.toLowerCase().contains('today');
        final isYesterday = act.dateGroup.toLowerCase().contains('yesterday');
        
        matchTime = times.any((f) {
          if (f == AssignedTicketFilter.timeToday && isToday) return true;
          if (f == AssignedTicketFilter.timeYesterday && isYesterday) return true;
          if (f == AssignedTicketFilter.timeLast7Days || f == AssignedTicketFilter.timeLast30Days) return true; // all mock data is within 7 days
          return false;
        });
      }

      return matchStatus && matchPriority && matchCategory && matchFloor && matchTime;
    }).toList();
  }
}
