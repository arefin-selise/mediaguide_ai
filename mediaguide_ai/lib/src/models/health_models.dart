class DaySummary {
  final String label;
  final double heartRate;
  final int steps;
  final List<double> hrSeries;

  DaySummary({
    required this.label,
    required this.heartRate,
    required this.steps,
    required this.hrSeries,
  });
}
