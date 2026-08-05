import '../../domain/entities/reservation_entity.dart';
import '../../domain/entities/reservation_summary_entity.dart';
import '../../domain/entities/reservation_statistics_entity.dart';
import '../../domain/entities/reservation_details_entity.dart';
import '../../domain/entities/timeline_event_entity.dart';
import '../../domain/repositories/reservation_repository.dart';

class MockReservationRepository implements ReservationRepository {
  final List<ReservationEntity> _mockReservations = [];

  @override
  Future<void> createReservation(ReservationEntity reservation) async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    _mockReservations.add(reservation);
  }

  @override
  Future<void> updateReservation(ReservationEntity reservation) async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    final index = _mockReservations.indexWhere((r) => r.id == reservation.id);
    if (index != -1) {
      _mockReservations[index] = reservation;
    }
  }

  @override
  Future<ReservationSummaryEntity> getReservationSummary() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const ReservationSummaryEntity(
      totalReservations: 42,
      completedReservations: 18,
      upcomingReservations: 20,
      cancelledReservations: 4,
      totalGuests: 126,
    );
  }

  @override
  Future<ReservationStatisticsEntity> getReservationStatistics() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const ReservationStatisticsEntity(
      hourlyOccupancy: [
        HourlyOccupancyEntity(timeLabel: '10 AM', count: 12, capacityPercentage: 0.3),
        HourlyOccupancyEntity(timeLabel: '11 AM', count: 25, capacityPercentage: 0.6),
        HourlyOccupancyEntity(timeLabel: '12 PM', count: 40, capacityPercentage: 0.95),
        HourlyOccupancyEntity(timeLabel: '1 PM', count: 35, capacityPercentage: 0.85),
        HourlyOccupancyEntity(timeLabel: '2 PM', count: 15, capacityPercentage: 0.4),
        HourlyOccupancyEntity(timeLabel: '3 PM', count: 20, capacityPercentage: 0.5),
      ],
      averagePartySize: 3.2,
      cancellationRate: 0.08,
      peakHour: '12:00 PM',
    );
  }

  @override
  Future<List<ReservationEntity>> getTodayReservations() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final now = DateTime.now();
    return [
      ReservationEntity(
        id: 'RES-001',
        customerName: 'Alice Johnson',
        time: DateTime(now.year, now.month, now.day, 12, 30),
        guestsCount: 4,
        status: ReservationStatus.confirmed,
        contactNumber: '+1 555-0101',
        specialRequests: 'Window seat if possible',
      ),
      ReservationEntity(
        id: 'RES-002',
        customerName: 'Bob Smith',
        time: DateTime(now.year, now.month, now.day, 13, 0),
        guestsCount: 2,
        status: ReservationStatus.checkedIn,
      ),
      ReservationEntity(
        id: 'RES-003',
        customerName: 'Charlie Davis',
        time: DateTime(now.year, now.month, now.day, 14, 15),
        guestsCount: 6,
        status: ReservationStatus.pending,
        contactNumber: '+1 555-0202',
        specialRequests: 'Birthday celebration',
      ),
      ReservationEntity(
        id: 'RES-004',
        customerName: 'Diana Prince',
        time: DateTime(now.year, now.month, now.day, 15, 0),
        guestsCount: 3,
        status: ReservationStatus.cancelled,
      ),
    ];
  }

  @override
  Future<ReservationDetailsEntity> getReservationDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final now = DateTime.now();
    return ReservationDetailsEntity(
      baseInfo: ReservationEntity(
        id: id,
        customerName: 'Alexander Pierce',
        time: DateTime(now.year, now.month, now.day, 18, 30),
        guestsCount: 4,
        status: ReservationStatus.confirmed,
        contactNumber: '+1 555-0123',
        specialRequests: null,
      ),
      membershipLevel: 'Gold Member',
      email: 'a.pierce@email.com',
      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAggDqeiRvK_w4isMKWlo6sgSbHVxnKr-W8zcuBTFNyAYxDMLux_YIeowGRJCuYSz93roUl0v83fL0tqccrFLnnzDepQqffOFgV4vv1XamtjB9w0B4ub2ZT0UKlURr7reJFjX1Fgevvd4pJ4y_LJQ7iHjT3l_q9lUnm7t1DA-qQ90lHmqduLgQ5x_F9Jd1xcbuN6Is44JpX_yiSMXNkVBP3JmpTutnYX1uvk3JZVJgzY1lRT-9YT3CVep_71CeE474fezqumJv4GA',
      insightTitle: 'High-value customer',
      insightDescription: 'Alexander has visited this location 8 times in the last 6 months.',
      table: 'Window Table 4',
      area: 'Main Floor',
      type: 'Dinner',
      preference: 'Quiet Area',
      occasion: 'Anniversary',
      bookingSource: 'Mobile App',
      specialRequestTags: const ['Window Seat', 'Birthday Celebration'],
      internalStaffNotes: '"VIP Customer - prefers window seating. Anniversary celebration - prepare complimentary dessert with a personalized message."',
      timeline: const [
        TimelineEventEntity(
          title: 'Reminder Sent',
          subtitle: 'Oct 23, 06:30 PM • SMS Notification',
          isPrimary: true,
          isPast: true,
        ),
        TimelineEventEntity(
          title: 'Confirmed',
          subtitle: 'Oct 20, 10:30 AM • System Auto-Confirm',
          isPrimary: false,
          isPast: true,
        ),
        TimelineEventEntity(
          title: 'Reservation Created',
          subtitle: 'Oct 20, 09:15 AM • Via Mobile App',
          isPrimary: false,
          isPast: true,
        ),
      ],
    );
  }

  Future<ReservationDetailsEntity> _updateMockDetailsStatus(String id, ReservationStatus newStatus, String timelineTitle, String timelineSubtitle) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final details = await getReservationDetails(id);
    final updatedBaseInfo = ReservationEntity(
      id: details.baseInfo.id,
      customerName: details.baseInfo.customerName,
      time: details.baseInfo.time,
      guestsCount: details.baseInfo.guestsCount,
      status: newStatus,
      contactNumber: details.baseInfo.contactNumber,
      specialRequests: details.baseInfo.specialRequests,
    );
    final newTimeline = [
      TimelineEventEntity(
        title: timelineTitle,
        subtitle: timelineSubtitle,
        isPrimary: true,
        isPast: true,
      ),
      ...details.timeline.map((e) => TimelineEventEntity(
        title: e.title,
        subtitle: e.subtitle,
        isPrimary: false,
        isPast: e.isPast,
      )),
    ];
    return ReservationDetailsEntity(
      baseInfo: updatedBaseInfo,
      membershipLevel: details.membershipLevel,
      email: details.email,
      avatarUrl: details.avatarUrl,
      insightTitle: details.insightTitle,
      insightDescription: details.insightDescription,
      table: details.table,
      area: details.area,
      type: details.type,
      preference: details.preference,
      occasion: details.occasion,
      bookingSource: details.bookingSource,
      specialRequestTags: details.specialRequestTags,
      internalStaffNotes: details.internalStaffNotes,
      timeline: newTimeline,
    );
  }

  @override
  Future<ReservationDetailsEntity> confirmReservation(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.confirmed, 'Reservation Confirmed', 'Staff Action • Confirmed');
  }

  @override
  Future<ReservationDetailsEntity> checkInReservation(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.checkedIn, 'Customer Checked In', 'Staff Action • Checked In');
  }

  @override
  Future<ReservationDetailsEntity> seatReservation(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.seated, 'Customer Seated', 'Staff Action • Seated');
  }

  @override
  Future<ReservationDetailsEntity> completeReservation(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.completed, 'Reservation Completed', 'Staff Action • Completed');
  }

  @override
  Future<ReservationDetailsEntity> cancelReservation(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.cancelled, 'Reservation Cancelled', 'Staff Action • Cancelled');
  }

  @override
  Future<ReservationDetailsEntity> markReservationNoShow(String id) {
    return _updateMockDetailsStatus(id, ReservationStatus.noShow, 'Marked No Show', 'Staff Action • No Show');
  }
}
