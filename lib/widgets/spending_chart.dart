import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const SpendingChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty) {
      return const Text("No data for chart");
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: data.map((item) {
            final value = (item['total'] as num).toDouble();

            return PieChartSectionData(
              value: value,
              title: "${item['category']}\n\$${value.toStringAsFixed(0)}",
            );
          }).toList(),
        ),
      ),
    );
  }
}