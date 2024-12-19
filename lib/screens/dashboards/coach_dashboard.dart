import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachDashboard extends StatefulWidget {
  const CoachDashboard({Key? key}) : super(key: key);

  @override
  _CoachDashboardState createState() => _CoachDashboardState();
}

class _CoachDashboardState extends State<CoachDashboard> {
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
        title: const Text('Coach Dashboard'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment, color: Colors.black),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Coach Dashboard!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTrainingDetailsScreen()),
                );
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
              'Add new training details',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Calendar Summary
            Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Training Schedule Summary',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Monday: Strength Training\nTuesday: Cardio\nWednesday: Rest Day\nThursday: HIIT\nFriday: Strength Training\nSaturday: Endurance Training\nSunday: Rest Day',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Group Performance Chart
            Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.all(16.0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Group Performance', textStyle: TextStyle(color: Colors.white)),
                legend: Legend(isVisible: true, textStyle: TextStyle(color: Colors.white)),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<CompetitiveData, String>(
                    dataSource: [
                      CompetitiveData('Athlete 1', 75),
                      CompetitiveData('Athlete 2', 80),
                      CompetitiveData('Athlete 3', 65),
                      CompetitiveData('Athlete 4', 90),
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
      ),
    );
  }
}


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  void _saveProfileDetails() {
    FirebaseFirestore.instance.collection('profiles').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'experience': _experienceController.text,
      'specialty': _specialtyController.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: 'Experience',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _specialtyController,
              decoration: InputDecoration(
                labelText: 'Specialty',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.amber),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileDetails,
              child: const Text('Save Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Main Detail Screen with Competition',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            // Group Performance Chart
            Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.all(16.0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Group Performance', textStyle: TextStyle(color: Colors.amber)),
                legend: Legend(isVisible: true, textStyle: TextStyle(color: Colors.amber)),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<CompetitiveData, String>(
                    dataSource: [
                      CompetitiveData('Athlete 1', 75),
                      CompetitiveData('Athlete 2', 80),
                      CompetitiveData('Athlete 3', 65),
                      CompetitiveData('Athlete 4', 90),
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
      ),
    );
  }
}
class TrainingScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> trainingSchedule = [
      'Monday: Strength Training',
      'Tuesday: Cardio',
      'Wednesday: Rest Day',
      'Thursday: HIIT',
      'Friday: Strength Training',
      'Saturday: Endurance Training',
      'Sunday: Rest Day',
    ];

    final List<String> availableCoaches = [
      'Coach A',
      'Coach B',
      'Coach C',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Training Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Training Schedule',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: trainingSchedule.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    trainingSchedule[index],
                    style: TextStyle(color: Colors.amber),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateTrainingDetailsScreen()),
                );
              },
              child: const Text('Update Training Schedule'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(height: 20),
            // UI for loading a workout
            Text(
              'Load Workout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Available Coach',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              items: availableCoaches.map((String coach) {
                return DropdownMenuItem<String>(
                  value: coach,
                  child: Text(coach),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle coach selection
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Rating',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                // Handle rating input
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Injuries',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (String value) {
                // Handle injuries input
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Minutes Played',
                labelStyle: TextStyle(color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                // Handle minutes played input
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle workout loading
              },
              child: const Text('Load Workout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AddTrainingDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Training Details'),
      ),
      body: Center(
        child: Text('Add Training Details Screen'),
      ),
    );
  }
}

class UpdateTrainingDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Training Details'),
      ),
      body: Center(
        child: Text('Update Training Details Screen'),
      ),
    );
  }
}

class WorkoutData {
  final String day;
  final int rpe;

  WorkoutData(this.day, this.rpe);
}

class CompetitiveData {
  final String name;
  final int score;

  CompetitiveData(this.name, this.score);
}
