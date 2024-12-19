import 'package:flutter/material.dart';
import 'package:restructure/screens/dashboards/coach_dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AthleteDashboard extends StatefulWidget {
  const AthleteDashboard({Key? key}) : super(key: key);

  @override
  _AthleteDashboardState createState() => _AthleteDashboardState();
}

class _AthleteDashboardState extends State<AthleteDashboard> {
  final List<WorkoutData> workoutData = [
    WorkoutData('Mon', 5),
    WorkoutData('Tue', 7),
    WorkoutData('Wed', 6),
    WorkoutData('Thu', 8),
    WorkoutData('Fri', 5),
    WorkoutData('Sat', 9),
    WorkoutData('Sun', 7),
  ];

  final List<CompetitiveData> competitiveData = [
    CompetitiveData('Athlete 1', 75),
    CompetitiveData('Athlete 2', 80),
    CompetitiveData('Athlete 3', 65),
    CompetitiveData('Athlete 4', 90),
    CompetitiveData('You', 85),
  ];

  final String athleteName = 'John Doe'; // Dummy value for athlete's name
  final List<String> trainingSchedule = [
    'Monday: Strength Training',
    'Tuesday: Cardio',
    'Wednesday: Rest Day',
    'Thursday: HIIT',
    'Friday: Strength Training',
    'Saturday: Endurance Training',
    'Sunday: Rest Day',
  ];

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen(),
    MainDetailScreen(),
    TrainingScheduleScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Athlete Dashboard'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Section
          Text(
            'Welcome, John Doe!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the screen for adding new data about RPE and workout details
            },
            child: const Icon(Icons.add, size: 50),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Add new data about RPE and workout details',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Heat Map
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Consistency Heat Map'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<WorkoutData, String>(
                  dataSource: [
                    WorkoutData('Mon', 5),
                    WorkoutData('Tue', 7),
                    WorkoutData('Wed', 6),
                    WorkoutData('Thu', 8),
                    WorkoutData('Fri', 5),
                    WorkoutData('Sat', 9),
                    WorkoutData('Sun', 7),
                  ],
                  xValueMapper: (WorkoutData data, _) => data.day,
                  yValueMapper: (WorkoutData data, _) => data.rpe,
                  name: 'Consistency',
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Name: John Doe',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Email: john.doe@example.com',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Age: 25',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Sport: Running',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class MainDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Section
          Text(
            'Welcome, John Doe!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the screen for adding new data about RPE and workout details
            },
            child: const Icon(Icons.add, size: 50),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Add new data about RPE and workout details',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // RPE Chart
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'RPE Over the Week'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<WorkoutData, String>(
                  dataSource: [
                    WorkoutData('Mon', 5),
                    WorkoutData('Tue', 7),
                    WorkoutData('Wed', 6),
                    WorkoutData('Thu', 8),
                    WorkoutData('Fri', 5),
                    WorkoutData('Sat', 9),
                    WorkoutData('Sun', 7),
                  ],
                  xValueMapper: (WorkoutData data, _) => data.day,
                  yValueMapper: (WorkoutData data, _) => data.rpe,
                  name: 'RPE',
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Competitive Performance',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Competitive Performance Chart
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Performance Comparison'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<CompetitiveData, String>(
                  dataSource: [
                    CompetitiveData('Athlete 1', 75),
                    CompetitiveData('Athlete 2', 80),
                    CompetitiveData('Athlete 3', 65),
                    CompetitiveData('Athlete 4', 90),
                    CompetitiveData('You', 85),
                  ],
                  xValueMapper: (CompetitiveData data, _) => data.name,
                  yValueMapper: (CompetitiveData data, _) => data.score,
                  name: 'Performance',
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
