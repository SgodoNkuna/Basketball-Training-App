import 'package:flutter/material.dart';
import '../models/performance_metric.dart';

class DetailScreen extends StatelessWidget {
  final PerformanceMetric metric;

  DetailScreen({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(metric.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${metric.description}'),
            Text('Date: ${metric.date.toLocal()}'),
            Text('Value: ${metric.value}'),
          ],
        ),
      ),
    );
  }
}
