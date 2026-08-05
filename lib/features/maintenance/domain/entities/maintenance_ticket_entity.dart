import 'package:equatable/equatable.dart';



class MaintenanceTicketEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String status;
  final String priority;
  final String reportedTime;
  final String category;
  final String? description;

  const MaintenanceTicketEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.status,
    required this.priority,
    required this.reportedTime,
    required this.category,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        status,
        priority,
        reportedTime,
        category,
        description,
      ];
}
