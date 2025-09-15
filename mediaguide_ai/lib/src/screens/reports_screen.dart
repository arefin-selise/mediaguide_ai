import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/health_providers.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(weeklySummariesProvider);
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final day = history[i];
          return ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(day.label),
            subtitle: Text('Avg HR: ${day.heartRate.toStringAsFixed(0)} bpm • Steps: ${day.steps}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}
