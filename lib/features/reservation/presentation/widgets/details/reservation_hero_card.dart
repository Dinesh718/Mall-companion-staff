import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../reservation/domain/entities/reservation_details_entity.dart';
import '../../../../reservation/domain/entities/reservation_entity.dart';

class ReservationHeroCard extends StatefulWidget {
  final ReservationDetailsEntity details;

  const ReservationHeroCard({super.key, required this.details});

  @override
  State<ReservationHeroCard> createState() => _ReservationHeroCardState();
}

class _ReservationHeroCardState extends State<ReservationHeroCard> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.details.baseInfo.status;
    final time = widget.details.baseInfo.time;
    final timeStr = "${time.hour > 12 ? (time.hour - 12) : (time.hour == 0 ? 12 : time.hour).toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final dateStr = "${weekdays[time.weekday - 1]}, ${months[time.month - 1]} ${time.day}";

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(51),
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative background element
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withAlpha(25),
                    blurRadius: 60.0,
                    spreadRadius: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RESERVATION ID',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withAlpha(204), // 80% opacity
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '#${widget.details.baseInfo.id}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51), // 20% opacity
                      border: Border.all(color: Colors.white.withAlpha(76)), // 30% opacity
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Row(
                      children: [
                        if (status == ReservationStatus.confirmed || status == ReservationStatus.checkedIn || status == ReservationStatus.seated)
                          FadeTransition(
                            opacity: _pulseController,
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              width: 8.0,
                              height: 8.0,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        Text(
                          _getStatusLabel(status),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 18.0, color: Colors.white.withAlpha(204)),
                            const SizedBox(width: 8.0),
                            Text(
                              'Date',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          dateStr,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(25),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule_rounded, size: 18.0, color: Colors.white.withAlpha(204)),
                              const SizedBox(width: 8.0),
                              Text(
                                'Time',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  color: Colors.white.withAlpha(204),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            timeStr,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(25),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.groups_rounded, size: 18.0, color: Colors.white.withAlpha(204)),
                            const SizedBox(width: 8.0),
                            Text(
                              'Party Size',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${widget.details.baseInfo.guestsCount} Guests',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.confirmed:
        return 'Confirmed';
      case ReservationStatus.checkedIn:
        return 'Checked In';
      case ReservationStatus.seated:
        return 'Seated';
      case ReservationStatus.completed:
        return 'Completed';
      case ReservationStatus.cancelled:
        return 'Cancelled';
      case ReservationStatus.noShow:
        return 'No Show';
      case ReservationStatus.pending:
        return 'Pending';
    }
  }
}
