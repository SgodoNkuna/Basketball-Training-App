import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> sportsCategories = [
    'Soccer',
    'Rugby',
    'Cricket',
    'Athletics',
    'Basketball',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...sportsCategories.map((sport) => Text(sport)).toList(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/athlete-login');
              },
              child: const Text('Athlete Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coach-login');
              },
              child: const Text('Coach Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin-login');
              },
              child: const Text('Admin Login'),
            ),
          ],
        ),
      ),
    );
  }
}
