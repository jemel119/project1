import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SpendingChart extends StatelessWidget {

  final List<Map<String, dynamic>> data;

  const SpendingChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    final series = [
      charts.Series<Map<String, dynamic>, String>(
        id: "Spending",
        data: data,
        domainFn: (d, _) => d['category'] ?? "Other",
        measureFn: (d, _) => (d['total'] as num).toDouble(),
        labelAccessorFn: (d, _) => "\$${d['total']}",
      )
    ];

    return SizedBox(
      height: 200,
      child: charts.BarChart(
        series,
        animate: true,
      ),
    );
  }
}