import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/maintenance/data/repositories/mock_maintenance_repository.dart';
import 'package:mall_companion_staff/features/maintenance/domain/entities/ticket_resolution_entity.dart';

void main() {
  late MockMaintenanceRepository repository;

  setUp(() {
    repository = MockMaintenanceRepository();
  });

  group('MockMaintenanceRepository Ticket Operations', () {
    test('acceptTicket updates status to Accepted and adds timeline event', () async {
      const ticketId = '#MT-2049'; // Initial status is Assigned
      await repository.acceptTicket(ticketId);

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'Accepted');
      expect(details.timeline.first.title, 'Ticket Accepted');
    });

    test('startWork updates status to In Progress and adds timeline event', () async {
      // Must transition from Accepted
      const ticketId = '#MT-2049'; 
      await repository.acceptTicket(ticketId);
      await repository.startWork(ticketId);

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'In Progress');
      expect(details.timeline.first.title, 'Started Work');
    });

    test('pauseWork updates status to Paused from In Progress', () async {
      const ticketId = '#MT-2045'; // Initial status is In Progress
      await repository.pauseWork(ticketId);

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'Paused');
      expect(details.timeline.first.title, 'Work Paused');
    });

    test('resumeWork updates status to In Progress from Paused', () async {
      const ticketId = '#MT-2045'; // Initial status is In Progress
      await repository.pauseWork(ticketId);
      await repository.resumeWork(ticketId);

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'In Progress');
      expect(details.timeline.first.title, 'Work Resumed');
    });

    test('escalateTicket updates status to Escalated', () async {
      const ticketId = '#MT-2045'; 
      await repository.escalateTicket(ticketId, 'Needs supervisor');

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'Escalated');
      expect(details.timeline.first.title, contains('Ticket Escalated'));
    });

    test('resolveTicket updates status to Resolved and adds note', () async {
      const ticketId = '#MT-2045'; // Initial status is In Progress
      await repository.resolveTicket(ticketId, const TicketResolutionEntity(
        workPerformed: 'Fixed leak',
        resolutionType: 'Permanent Fix',
      ));

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'Resolved');
      expect(details.notes.first.content, 'Resolution [Permanent Fix]: Fixed leak');
      expect(details.timeline.first.title, 'Note Added by Alex');
    });

    test('closeTicket updates status to Closed from Resolved', () async {
      const ticketId = '#MT-2045'; 
      await repository.resolveTicket(ticketId, const TicketResolutionEntity(
        workPerformed: 'Fixed leak',
        resolutionType: 'Permanent Fix',
      ));
      await repository.closeTicket(ticketId);

      final details = await repository.getTicketDetails(ticketId);
      expect(details.status, 'Closed');
      expect(details.timeline.first.title, 'Ticket Closed');
    });

    test('invalid transition throws Exception', () async {
      const ticketId = '#MT-2051'; // Initial status is Assigned
      // Trying to start work directly from Assigned should fail
      expect(
        () async => await repository.startWork(ticketId),
        throwsException,
      );
    });
  });
}
