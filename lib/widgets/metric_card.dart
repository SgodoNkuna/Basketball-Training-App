import 'package:flutter/material.dart';
import '../models/performance_metric.dart';
import '../screens/detail_screen.dart';

class MetricCard extends StatelessWidget {
  final PerformanceMetric metric;

  MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(metric.name),
        subtitle: Text(metric.description),
        trailing: Text(metric.value.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(metric: metric)),
          );
        },
      ),
    );
  }
}
