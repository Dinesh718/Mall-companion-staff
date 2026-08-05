import '../../domain/entities/queue_entity.dart';
import '../../domain/entities/queue_status.dart';
import '../../domain/entities/queue_summary_entity.dart';
import '../../domain/entities/queue_analytics_entity.dart';
import '../../domain/entities/queue_analytics_summary_entity.dart';
import '../../domain/entities/queue_status_distribution_entity.dart';
import '../../domain/entities/hourly_queue_trend_entity.dart';
import '../../domain/entities/performance_metrics_entity.dart';
import '../../domain/entities/insight_entity.dart';
import '../../domain/entities/staff_performance_entity.dart';
import '../../domain/entities/queue_timeline_step_entity.dart';
import '../../domain/entities/queue_timeline_step_status.dart';
import '../../domain/entities/create_queue_entry_entity.dart';
import '../../domain/entities/queue_priority.dart';
import '../../domain/repositories/queue_repository.dart';
import '../../domain/entities/queue_filter.dart';
import '../../domain/entities/queue_sort_option.dart';

class MockQueueRepository implements QueueRepository {
  late final List<QueueEntity> _queueList;

  MockQueueRepository({bool populateAll = false}) {
    final now = DateTime.now();

    _queueList = [
      QueueEntity(
        id: 'q1',
        token: 'A012',
        customerName: 'James Wilson',
        phoneNumber: '555-0123',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRtCAoLCaBjyKov7GTYHc5bbXtfjjeYFJXjadEY7XSDMaApcruNv5QI9vX9j7k0jjspWoaWcnNaTy4LO8eS4bOfV4aYu3jMLzsi_D9tEPKvSgY1gZrCE-zK9LbpJhUjL2n2ofGSKjWXIfeYnrbbCLZWctPduwfg79JUe_8WqhlpdkNwkID7sGv3fbLhds8KyiXhrw8oDYuA4q63qk_FMIkx0oDyxiDe_BnSPjgG7qF215T1ZCpP1fZTGbwDLywJhVm8FqwfaQ7Lw',
        partySize: 2,
        estimatedWaitMinutes: 15,
        checkInTime: now.subtract(const Duration(minutes: 15)),
        status: QueueStatus.waiting,
        specialNotes: 'Customer requested window seating. Birthday celebration.',
        position: 4,
        serviceType: 'Walk-in',
        priority: 'Standard',
        contactPreference: 'SMS',
        membershipLevel: 'Loyalty Member',
        timelineSteps: [
          QueueTimelineStepEntity(
            title: 'Checked In',
            subtitle: '10:15 AM • Front Desk',
            timestamp: now.subtract(const Duration(minutes: 15)),
            status: QueueTimelineStepStatus.completed,
          ),
          QueueTimelineStepEntity(
            title: 'Waiting',
            subtitle: 'Est. Call at 10:30 AM',
            timestamp: now,
            status: QueueTimelineStepStatus.current,
          ),
          QueueTimelineStepEntity(
            title: 'Called',
            subtitle: 'Next Step',
            timestamp: now.add(const Duration(minutes: 15)),
            status: QueueTimelineStepStatus.future,
          ),
          QueueTimelineStepEntity(
            title: 'Serving',
            subtitle: 'In-service',
            timestamp: now.add(const Duration(minutes: 30)),
            status: QueueTimelineStepStatus.future,
          ),
          QueueTimelineStepEntity(
            title: 'Completed',
            subtitle: 'Final Stage',
            timestamp: now.add(const Duration(minutes: 45)),
            status: QueueTimelineStepStatus.future,
          ),
        ],
      ),
      QueueEntity(
        id: 'q2',
        token: 'A015',
        customerName: 'Sarah Mitchell',
        phoneNumber: '555-0189',
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuABNQrk8kKmKiCuEvub2YDMONtD98MIRBc2PlJag9hagWrwzs89OzKn2YhOGzDV88VnmGG1mo6ewkOr7F-JNiRuVT0qY5pALXNIgbUnyLguA-LoA9mtGc-pLdG5P5rwXwnNBH6H9R4-t0AtCzRS5mfB7EiN4oR6z5WqZwltTRbUxOBq15G-MiF5IFyXFdb_hIhEFw30U5URy7PVCOyQVI_nm_H1KCC9If_wZJ3iecU0PK2Nqj5AuIBeY4o0Dinn-6FJNdcpX7cSqQ',
        partySize: 1,
        estimatedWaitMinutes: 8,
        checkInTime: now.subtract(const Duration(minutes: 8)),
        status: QueueStatus.waiting,
        specialNotes: null,
        position: 5,
        serviceType: 'Walk-in',
        priority: 'Standard',
        contactPreference: 'SMS',
        membershipLevel: 'Loyalty Member',
        timelineSteps: [
          QueueTimelineStepEntity(
            title: 'Checked In',
            subtitle: '10:22 AM • Front Desk',
            timestamp: now.subtract(const Duration(minutes: 8)),
            status: QueueTimelineStepStatus.completed,
          ),
          QueueTimelineStepEntity(
            title: 'Waiting',
            subtitle: 'Est. Call at 10:30 AM',
            timestamp: now,
            status: QueueTimelineStepStatus.current,
          ),
          QueueTimelineStepEntity(
            title: 'Called',
            subtitle: 'Next Step',
            timestamp: now.add(const Duration(minutes: 8)),
            status: QueueTimelineStepStatus.future,
          ),
          QueueTimelineStepEntity(
            title: 'Serving',
            subtitle: 'In-service',
            timestamp: now.add(const Duration(minutes: 20)),
            status: QueueTimelineStepStatus.future,
          ),
          QueueTimelineStepEntity(
            title: 'Completed',
            subtitle: 'Final Stage',
            timestamp: now.add(const Duration(minutes: 35)),
            status: QueueTimelineStepStatus.future,
          ),
        ],
      ),
      if (populateAll) ...[
        QueueEntity(
          id: 'q3',
          token: 'A018',
          customerName: 'David Lee',
          phoneNumber: '555-0210',
          avatarUrl: '',
          partySize: 4,
          estimatedWaitMinutes: 0,
          checkInTime: now.subtract(const Duration(minutes: 25)),
          status: QueueStatus.called,
          specialNotes: 'VIP Customer. Requested priority service.',
          position: 1,
          serviceType: 'Walk-in',
          priority: 'VIP',
          contactPreference: 'SMS',
          membershipLevel: 'VIP Member',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '10:05 AM • Front Desk',
              timestamp: now.subtract(const Duration(minutes: 25)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Customer Called',
              subtitle: '10:20 AM • Station 1',
              timestamp: now.subtract(const Duration(minutes: 10)),
              status: QueueTimelineStepStatus.current,
            ),
          ],
        ),
        QueueEntity(
          id: 'q4',
          token: 'A020',
          customerName: 'Emily Davis',
          phoneNumber: '555-0222',
          avatarUrl: '',
          partySize: 3,
          estimatedWaitMinutes: 0,
          checkInTime: now.subtract(const Duration(minutes: 30)),
          status: QueueStatus.arrived,
          specialNotes: 'Wheelchair access required.',
          position: 2,
          serviceType: 'Booking',
          priority: 'Senior',
          contactPreference: 'Call',
          membershipLevel: 'Standard Visitor',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '10:00 AM • Front Desk',
              timestamp: now.subtract(const Duration(minutes: 30)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Customer Arrived',
              subtitle: '10:25 AM • Front Desk',
              timestamp: now.subtract(const Duration(minutes: 5)),
              status: QueueTimelineStepStatus.current,
            ),
          ],
        ),
        QueueEntity(
          id: 'q5',
          token: 'A022',
          customerName: 'Michael Brown',
          phoneNumber: '555-0333',
          avatarUrl: '',
          partySize: 2,
          estimatedWaitMinutes: 0,
          checkInTime: now.subtract(const Duration(minutes: 40)),
          status: QueueStatus.serving,
          specialNotes: null,
          position: 3,
          serviceType: 'Walk-in',
          priority: 'Standard',
          contactPreference: 'SMS',
          membershipLevel: 'Loyalty Member',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '9:50 AM',
              timestamp: now.subtract(const Duration(minutes: 40)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Service Started',
              subtitle: '10:10 AM • Station 2',
              timestamp: now.subtract(const Duration(minutes: 20)),
              status: QueueTimelineStepStatus.current,
            ),
          ],
        ),
        QueueEntity(
          id: 'q6',
          token: 'A025',
          customerName: 'Jessica Taylor',
          phoneNumber: '555-0444',
          avatarUrl: '',
          partySize: 1,
          estimatedWaitMinutes: 0,
          checkInTime: now.subtract(const Duration(minutes: 60)),
          status: QueueStatus.completed,
          specialNotes: null,
          position: 0,
          serviceType: 'Walk-in',
          priority: 'Standard',
          contactPreference: 'SMS',
          membershipLevel: 'Standard Visitor',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '9:30 AM',
              timestamp: now.subtract(const Duration(minutes: 60)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Service Completed',
              subtitle: '10:05 AM',
              timestamp: now.subtract(const Duration(minutes: 25)),
              status: QueueTimelineStepStatus.completed,
            ),
          ],
        ),
        QueueEntity(
          id: 'q7',
          token: 'A028',
          customerName: 'Robert Smith',
          phoneNumber: '555-0555',
          avatarUrl: '',
          partySize: 5,
          estimatedWaitMinutes: 0,
          checkInTime: now.subtract(const Duration(minutes: 50)),
          status: QueueStatus.cancelled,
          specialNotes: null,
          position: 0,
          serviceType: 'Walk-in',
          priority: 'Standard',
          contactPreference: 'SMS',
          membershipLevel: 'Standard Visitor',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '9:40 AM',
              timestamp: now.subtract(const Duration(minutes: 50)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Queue Cancelled',
              subtitle: '10:00 AM • No Show',
              timestamp: now.subtract(const Duration(minutes: 30)),
              status: QueueTimelineStepStatus.completed,
            ),
          ],
        ),
        QueueEntity(
          id: 'q8',
          token: 'A030',
          customerName: 'Linda Johnson',
          phoneNumber: '555-0666',
          avatarUrl: '',
          partySize: 2,
          estimatedWaitMinutes: 15,
          checkInTime: now.subtract(const Duration(minutes: 10)),
          status: QueueStatus.waiting,
          specialNotes: 'Skipped customer. Re-prioritized.',
          position: 6,
          serviceType: 'Walk-in',
          priority: 'VIP',
          contactPreference: 'SMS',
          membershipLevel: 'VIP Member',
          timelineSteps: [
            QueueTimelineStepEntity(
              title: 'Checked In',
              subtitle: '10:20 AM',
              timestamp: now.subtract(const Duration(minutes: 10)),
              status: QueueTimelineStepStatus.completed,
            ),
            QueueTimelineStepEntity(
              title: 'Customer Skipped',
              subtitle: '10:25 AM • Re-queued',
              timestamp: now.subtract(const Duration(minutes: 5)),
              status: QueueTimelineStepStatus.current,
            ),
          ],
        ),
      ],
    ];
  }

  @override
  Future<List<QueueEntity>> getCurrentQueue() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _queueList;
  }

  @override
  Future<QueueSummaryEntity> getQueueSummary() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const QueueSummaryEntity(
      waitingCount: 32,
      servingCount: 5,
      completedCount: 128,
      cancelledCount: 4,
      avgWaitTimeMinutes: 12,
      healthStatus: 'Excellent Health',
      currentDate: 'October 24, 2023',
    );
  }

  @override
  Future<QueueEntity> getQueueDetails(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _queueList.firstWhere(
      (element) => element.id == queueId,
      orElse: () => throw Exception('Queue details not found for ID: $queueId'),
    );
  }

  @override
  Future<QueueEntity> createQueueEntry(CreateQueueEntryEntity entry) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final now = DateTime.now();
    final newId = 'q${_queueList.length + 1}';
    final tokenNum = 12 + _queueList.length * 3;
    final newToken = 'A${tokenNum.toString().padLeft(3, '0')}';

    final newQueueItem = QueueEntity(
      id: newId,
      token: newToken,
      customerName: entry.customerName,
      phoneNumber: entry.phoneNumber,
      avatarUrl: '',
      partySize: entry.partySize,
      estimatedWaitMinutes: 12,
      checkInTime: now,
      status: QueueStatus.waiting,
      specialNotes: entry.internalNotes.isNotEmpty ? entry.internalNotes : null,
      position: _queueList.length + 4,
      serviceType: entry.serviceType,
      priority: entry.priority.toDisplayString(),
      contactPreference: entry.contactPreference,
      membershipLevel: entry.priority == QueuePriority.vip ? 'VIP Member' : 'Standard Visitor',
      timelineSteps: [
        QueueTimelineStepEntity(
          title: 'Checked In',
          subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • Desk',
          timestamp: now,
          status: QueueTimelineStepStatus.completed,
        ),
        QueueTimelineStepEntity(
          title: 'Waiting',
          subtitle: 'Est. Call in 12 mins',
          timestamp: now,
          status: QueueTimelineStepStatus.current,
        ),
      ],
    );

    _queueList.add(newQueueItem);
    return newQueueItem;
  }

  @override
  Future<Map<String, String>> validateQueueEntry(CreateQueueEntryEntity entry) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final errors = <String, String>{};
    if (entry.customerName.trim().isEmpty) {
      errors['customerName'] = 'Customer name is required';
    }
    if (entry.phoneNumber.trim().isEmpty) {
      errors['phoneNumber'] = 'Mobile number is required';
    }
    return errors;
  }

  @override
  Future<QueueEntity> callCustomer(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Customer Called',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • SMS Sent',
      timestamp: now,
      status: QueueTimelineStepStatus.current,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 0,
      checkInTime: item.checkInTime,
      status: QueueStatus.called,
      specialNotes: item.specialNotes,
      position: item.position,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<QueueEntity> markArrived(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Customer Arrived',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • In-person',
      timestamp: now,
      status: QueueTimelineStepStatus.current,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 0,
      checkInTime: item.checkInTime,
      status: QueueStatus.arrived,
      specialNotes: item.specialNotes,
      position: item.position,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<QueueEntity> startService(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Service Started',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • Station 3',
      timestamp: now,
      status: QueueTimelineStepStatus.current,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 0,
      checkInTime: item.checkInTime,
      status: QueueStatus.serving,
      specialNotes: item.specialNotes,
      position: item.position,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<QueueEntity> completeService(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Service Completed',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • Done',
      timestamp: now,
      status: QueueTimelineStepStatus.completed,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 0,
      checkInTime: item.checkInTime,
      status: QueueStatus.completed,
      specialNotes: item.specialNotes,
      position: 0,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<QueueEntity> skipCustomer(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Customer Skipped',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • Re-queued',
      timestamp: now,
      status: QueueTimelineStepStatus.current,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 15,
      checkInTime: item.checkInTime,
      status: QueueStatus.waiting,
      specialNotes: item.specialNotes,
      position: (item.position ?? 0) + 2,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<QueueEntity> cancelQueue(String queueId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _queueList.indexWhere((element) => element.id == queueId);
    if (idx == -1) throw Exception('Customer not found for ID: $queueId');
    final now = DateTime.now();
    final item = _queueList[idx];

    final updatedTimeline = List<QueueTimelineStepEntity>.from(item.timelineSteps ?? []);
    for (int i = 0; i < updatedTimeline.length; i++) {
      if (updatedTimeline[i].status == QueueTimelineStepStatus.current) {
        updatedTimeline[i] = QueueTimelineStepEntity(
          title: updatedTimeline[i].title,
          subtitle: updatedTimeline[i].subtitle,
          timestamp: updatedTimeline[i].timestamp,
          status: QueueTimelineStepStatus.completed,
        );
      }
    }
    updatedTimeline.add(QueueTimelineStepEntity(
      title: 'Queue Cancelled',
      subtitle: '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'} • No Show / Manual',
      timestamp: now,
      status: QueueTimelineStepStatus.completed,
    ));

    final updated = QueueEntity(
      id: item.id,
      token: item.token,
      customerName: item.customerName,
      phoneNumber: item.phoneNumber,
      avatarUrl: item.avatarUrl,
      partySize: item.partySize,
      estimatedWaitMinutes: 0,
      checkInTime: item.checkInTime,
      status: QueueStatus.cancelled,
      specialNotes: item.specialNotes,
      position: 0,
      serviceType: item.serviceType,
      priority: item.priority,
      contactPreference: item.contactPreference,
      membershipLevel: item.membershipLevel,
      timelineSteps: updatedTimeline,
    );

    _queueList[idx] = updated;
    return updated;
  }

  @override
  Future<List<QueueEntity>> searchQueue(String query) async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (query.isEmpty) return _queueList;
    final lowercaseQuery = query.toLowerCase();
    return _queueList.where((item) =>
      item.customerName.toLowerCase().contains(lowercaseQuery) ||
      item.token.toLowerCase().contains(lowercaseQuery) ||
      item.phoneNumber.contains(lowercaseQuery) ||
      item.id.toLowerCase().contains(lowercaseQuery)
    ).toList();
  }

  @override
  Future<List<QueueEntity>> filterQueue(QueueFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (filter == QueueFilter.all) return _queueList;
    if (filter == QueueFilter.skipped) {
      return _queueList.where((item) =>
        item.timelineSteps?.any((step) => step.title.toLowerCase().contains('skipped')) ?? false
      ).toList();
    }
    final statusEnum = QueueStatus.values.firstWhere(
      (e) => e.name == filter.name,
      orElse: () => QueueStatus.waiting,
    );
    return _queueList.where((item) => item.status == statusEnum).toList();
  }

  @override
  Future<List<QueueEntity>> sortQueue(QueueSortOption sortOption) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final sorted = List<QueueEntity>.from(_queueList);
    switch (sortOption) {
      case QueueSortOption.oldestFirst:
      case QueueSortOption.longestWaiting:
        sorted.sort((a, b) => a.checkInTime.compareTo(b.checkInTime));
        break;
      case QueueSortOption.newestFirst:
      case QueueSortOption.shortestWaiting:
        sorted.sort((a, b) => b.checkInTime.compareTo(a.checkInTime));
        break;
      case QueueSortOption.highestPriority:
        sorted.sort((a, b) {
          final priorityComparison = _getPriorityRank(b.priority).compareTo(_getPriorityRank(a.priority));
          if (priorityComparison != 0) return priorityComparison;
          return a.checkInTime.compareTo(b.checkInTime);
        });
        break;
      case QueueSortOption.largestPartySize:
        sorted.sort((a, b) {
          final partyComparison = b.partySize.compareTo(a.partySize);
          if (partyComparison != 0) return partyComparison;
          return a.checkInTime.compareTo(b.checkInTime);
        });
        break;
    }
    return sorted;
  }

  int _getPriorityRank(String? priority) {
    if (priority == null) return 0;
    switch (priority.trim().toLowerCase()) {
      case 'vip':
        return 3;
      case 'senior':
        return 2;
      case 'normal':
      case 'standard':
        return 1;
      default:
        return 0;
    }
  }

  @override
  Future<QueueAnalyticsEntity> getQueueAnalytics({required String range}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final now = DateTime.now();

    if (range.toLowerCase() == 'yesterday') {
      return QueueAnalyticsEntity(
        todayCustomersCount: 110,
        completedCount: 75,
        completedChange: 0.05,
        waitingCount: 0,
        avgWaitMinutes: 14,
        avgWaitStatus: 'Acceptable',
        lastUpdated: now.subtract(const Duration(hours: 24)),
        summary: const QueueAnalyticsSummaryEntity(
          todayVisitors: 110,
          todayVisitorsChange: 0.05,
          avgServiceTimeMinutes: 20,
          avgServiceTimeChange: 0.02,
          cancelledCount: 8,
          cancelledChange: 0.10,
          peakHour: '2 PM',
          peakHourLabel: 'Yesterday Peak',
        ),
        distribution: const [
          QueueStatusDistributionEntity(status: 'Waiting', count: 0, percentage: 0.0, colorHex: '6100D6'),
          QueueStatusDistributionEntity(status: 'Called', count: 0, percentage: 0.0, colorHex: '2170E4'),
          QueueStatusDistributionEntity(status: 'Arrived', count: 0, percentage: 0.0, colorHex: '0058BE'),
          QueueStatusDistributionEntity(status: 'Serving', count: 0, percentage: 0.0, colorHex: 'FFB68E'),
          QueueStatusDistributionEntity(status: 'Cancelled', count: 15, percentage: 13.6, colorHex: 'BA1A1A'),
          QueueStatusDistributionEntity(status: 'Completed', count: 95, percentage: 86.4, colorHex: 'D3E4FE'),
        ],
        hourlyTrends: const [
          HourlyQueueTrendEntity(hourLabel: '10A', todayCount: 12, averageCount: 15),
          HourlyQueueTrendEntity(hourLabel: '11A', todayCount: 15, averageCount: 22),
          HourlyQueueTrendEntity(hourLabel: '12P', todayCount: 25, averageCount: 28),
          HourlyQueueTrendEntity(hourLabel: '01P', todayCount: 35, averageCount: 35),
          HourlyQueueTrendEntity(hourLabel: '02P', todayCount: 40, averageCount: 33),
          HourlyQueueTrendEntity(hourLabel: '03P', todayCount: 28, averageCount: 25),
          HourlyQueueTrendEntity(hourLabel: '04P', todayCount: 18, averageCount: 18),
        ],
        performance: const PerformanceMetricsEntity(
          completionRate: 0.86,
          completionRateLabel: 'Average Performance',
          cancellationRate: 0.14,
          cancellationRateLabel: 'Slightly High',
          isStable: false,
          stabilityMessage: 'System experienced minor load spikes yesterday.',
        ),
        insights: const [
          InsightEntity(type: 'peak_activity', title: 'Peak Activity', description: 'Max queue length at 2:00 PM with 40 users.', colorHex: '7B2FF7'),
          InsightEntity(type: 'wait_improvement', title: 'Wait Increase', description: 'Wait time increased by 5% vs weekly average.', colorHex: 'FF8E8E'),
          InsightEntity(type: 'vip_handling', title: 'VIP Handling', description: 'Priority members served in 6 minutes average.', colorHex: 'FFB68E'),
        ],
        staffPerformance: const StaffPerformanceEntity(
          activeStaffCount: 4,
          avgCustomersServedPerStaff: 27,
          fastestServiceMinutes: 10,
          teamEfficiency: 0.80,
        ),
      );
    } else if (range.toLowerCase() == 'this week') {
      return QueueAnalyticsEntity(
        todayCustomersCount: 780,
        completedCount: 590,
        completedChange: 0.18,
        waitingCount: 32,
        avgWaitMinutes: 13,
        avgWaitStatus: 'Optimal',
        lastUpdated: now.subtract(const Duration(minutes: 15)),
        summary: const QueueAnalyticsSummaryEntity(
          todayVisitors: 780,
          todayVisitorsChange: 0.18,
          avgServiceTimeMinutes: 17,
          avgServiceTimeChange: -0.06,
          cancelledCount: 28,
          cancelledChange: -0.05,
          peakHour: '12 PM',
          peakHourLabel: 'Weekly Peak',
        ),
        distribution: const [
          QueueStatusDistributionEntity(status: 'Waiting', count: 45, percentage: 5.8, colorHex: '6100D6'),
          QueueStatusDistributionEntity(status: 'Called', count: 30, percentage: 3.8, colorHex: '2170E4'),
          QueueStatusDistributionEntity(status: 'Arrived', count: 25, percentage: 3.2, colorHex: '0058BE'),
          QueueStatusDistributionEntity(status: 'Serving', count: 15, percentage: 1.9, colorHex: 'FFB68E'),
          QueueStatusDistributionEntity(status: 'Cancelled', count: 50, percentage: 6.4, colorHex: 'BA1A1A'),
          QueueStatusDistributionEntity(status: 'Completed', count: 615, percentage: 78.9, colorHex: 'D3E4FE'),
        ],
        hourlyTrends: const [
          HourlyQueueTrendEntity(hourLabel: '10A', todayCount: 14, averageCount: 15),
          HourlyQueueTrendEntity(hourLabel: '11A', todayCount: 22, averageCount: 22),
          HourlyQueueTrendEntity(hourLabel: '12P', todayCount: 32, averageCount: 28),
          HourlyQueueTrendEntity(hourLabel: '01P', todayCount: 40, averageCount: 35),
          HourlyQueueTrendEntity(hourLabel: '02P', todayCount: 35, averageCount: 33),
          HourlyQueueTrendEntity(hourLabel: '03P', todayCount: 24, averageCount: 25),
          HourlyQueueTrendEntity(hourLabel: '04P', todayCount: 17, averageCount: 18),
        ],
        performance: const PerformanceMetricsEntity(
          completionRate: 0.91,
          completionRateLabel: 'Above Target Performance',
          cancellationRate: 0.06,
          cancellationRateLabel: 'Within Expected Range',
          isStable: true,
          stabilityMessage: 'System is Stable with standard weekly loads.',
        ),
        insights: const [
          InsightEntity(type: 'peak_activity', title: 'Weekly Peak', description: 'Weekly average peak at 12:00 PM.', colorHex: '7B2FF7'),
          InsightEntity(type: 'wait_improvement', title: 'Wait Improvement', description: 'Wait time decreased by 8% overall this week.', colorHex: '2E7D32'),
          InsightEntity(type: 'vip_handling', title: 'VIP Handling', description: 'Priority members served in under 5 minutes average.', colorHex: 'FFB68E'),
        ],
        staffPerformance: const StaffPerformanceEntity(
          activeStaffCount: 6,
          avgCustomersServedPerStaff: 130,
          fastestServiceMinutes: 6,
          teamEfficiency: 0.85,
        ),
      );
    } else {
      // 'Today' or default
      return QueueAnalyticsEntity(
        todayCustomersCount: 124,
        completedCount: 86,
        completedChange: 0.12,
        waitingCount: 32,
        avgWaitMinutes: 12,
        avgWaitStatus: 'Optimal',
        lastUpdated: now.subtract(const Duration(minutes: 2)),
        summary: const QueueAnalyticsSummaryEntity(
          todayVisitors: 124,
          todayVisitorsChange: 0.08,
          avgServiceTimeMinutes: 18,
          avgServiceTimeChange: -0.04,
          cancelledCount: 5,
          cancelledChange: -0.02,
          peakHour: '1 PM',
          peakHourLabel: 'Daily Peak',
        ),
        distribution: const [
          QueueStatusDistributionEntity(status: 'Waiting', count: 38, percentage: 30.6, colorHex: '6100D6'),
          QueueStatusDistributionEntity(status: 'Called', count: 24, percentage: 19.4, colorHex: '2170E4'),
          QueueStatusDistributionEntity(status: 'Arrived', count: 18, percentage: 14.5, colorHex: '0058BE'),
          QueueStatusDistributionEntity(status: 'Serving', count: 12, percentage: 9.7, colorHex: 'FFB68E'),
          QueueStatusDistributionEntity(status: 'Cancelled', count: 10, percentage: 8.1, colorHex: 'BA1A1A'),
          QueueStatusDistributionEntity(status: 'Completed', count: 22, percentage: 17.7, colorHex: 'D3E4FE'),
        ],
        hourlyTrends: const [
          HourlyQueueTrendEntity(hourLabel: '10A', todayCount: 10, averageCount: 15),
          HourlyQueueTrendEntity(hourLabel: '11A', todayCount: 18, averageCount: 22),
          HourlyQueueTrendEntity(hourLabel: '12P', todayCount: 30, averageCount: 28),
          HourlyQueueTrendEntity(hourLabel: '01P', todayCount: 45, averageCount: 35),
          HourlyQueueTrendEntity(hourLabel: '02P', todayCount: 32, averageCount: 33),
          HourlyQueueTrendEntity(hourLabel: '03P', todayCount: 20, averageCount: 25),
          HourlyQueueTrendEntity(hourLabel: '04P', todayCount: 15, averageCount: 18),
        ],
        performance: const PerformanceMetricsEntity(
          completionRate: 0.94,
          completionRateLabel: 'Above Target Performance',
          cancellationRate: 0.04,
          cancellationRateLabel: 'Within Expected Range',
          isStable: true,
          stabilityMessage: 'System is Stable with high routing efficiency.',
        ),
        insights: const [
          InsightEntity(type: 'peak_activity', title: 'Peak Activity', description: 'Max queue length at 1:00 PM with 45 users.', colorHex: '7B2FF7'),
          InsightEntity(type: 'wait_improvement', title: 'Wait Improvement', description: 'Wait time decreased by 12% vs last week.', colorHex: '2E7D32'),
          InsightEntity(type: 'vip_handling', title: 'VIP Handling', description: 'Priority members served in under 4 minutes.', colorHex: 'FFB68E'),
        ],
        staffPerformance: const StaffPerformanceEntity(
          activeStaffCount: 5,
          avgCustomersServedPerStaff: 24,
          fastestServiceMinutes: 8,
          teamEfficiency: 0.88,
        ),
      );
    }
  }
}
