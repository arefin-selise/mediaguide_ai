import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/health_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todaySummaryProvider);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => ref.read(healthServiceProvider).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Welcome to MediGuide AI', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Heart rate'),
                subtitle: Text('${today.heartRate.toStringAsFixed(0)} bpm'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.directions_walk, color: Colors.teal),
                title: const Text('Steps'),
                subtitle: Text('${today.steps} steps'),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.teal,
                          spots: today.hrSeries
                              .asMap()
                              .entries
                              .map((e) => FlSpot(e.key.toDouble(), e.value))
                              .toList(),
                        ),
                      ],
                      titlesData: const FlTitlesData(show: false),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
