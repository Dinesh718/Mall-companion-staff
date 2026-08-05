import '../entities/emergency_entity.dart';
import '../entities/emergency_summary_entity.dart';
import '../entities/emergency_overview_entity.dart';
import '../entities/emergency_filter_entity.dart';

abstract class EmergencyResponseRepository {
  Future<List<EmergencyEntity>> getEmergencies(EmergencyFilterEntity filter);
  Future<EmergencySummaryEntity> getEmergencySummary();
  Future<EmergencyOverviewEntity> getEmergencyOverview();
}
