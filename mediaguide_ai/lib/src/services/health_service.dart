import '../models/health_models.dart';

abstract class HealthService {
  DaySummary get todaySummary;
  List<DaySummary> get weeklySummaries;
  Future<void> refresh();
}

// TODO: Implement HealthKit (iOS), Google Fit / Samsung Health (Android), and Zepp (Amazfit)
// Create platform-specific implementations and wire via conditional imports if needed.
