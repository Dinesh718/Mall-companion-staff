import 'package:equatable/equatable.dart';

class MaintenanceActivityEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle; // e.g. "#MT-1842 • 15 mins ago"
  final String type; // e.g. "resolved", "started"

  const MaintenanceActivityEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, type];
}
