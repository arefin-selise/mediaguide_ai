import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/health_models.dart';
import '../services/health_service.dart';

final healthServiceProvider = Provider<HealthService>((ref) => DummyHealthService());

final todaySummaryProvider = Provider<DaySummary>((ref) {
  return ref.watch(healthServiceProvider).todaySummary;
});

final weeklySummariesProvider = Provider<List<DaySummary>>((ref) {
  return ref.watch(healthServiceProvider).weeklySummaries;
});

// Simple dummy implementation for now, replace with real integrations
class DummyHealthService implements HealthService {
  final _rng = Random(42);

  @override
  DaySummary get todaySummary => DaySummary(
        label: 'Today',
        heartRate: 62 + _rng.nextDouble() * 20,
        steps: 4000 + _rng.nextInt(4000),
        hrSeries: List.generate(24, (i) => 60 + _rng.nextDouble() * 30),
      );

  @override
  List<DaySummary> get weeklySummaries => List.generate(7, (i) {
        return DaySummary(
          label: 'Day ${i + 1}',
          heartRate: 60 + _rng.nextDouble() * 25,
          steps: 3000 + _rng.nextInt(6000),
          hrSeries: List.generate(24, (i) => 60 + _rng.nextDouble() * 30),
        );
      });

  @override
  Future<void> refresh() async {}
}
