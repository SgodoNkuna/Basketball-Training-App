import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/logins/athlete_login_screen.dart';
import 'screens/logins/coach_login_screen.dart';
import 'screens/logins/admin_login_screen.dart';
import 'screens/logins/login_screen.dart';
import 'screens/logins/create_account_screen.dart';
import 'screens/logins/forgot_password_screen.dart';
import 'screens/dashboards/athlete_dashboard.dart';
import 'screens/dashboards/coach_dashboard.dart';
import 'screens/dashboards/admin_dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "",
      authDomain: "performace-tracking-app.firebaseapp.com",
      projectId: "performace-tracking-app",
      storageBucket: "performace-tracking-app.appspot.com",
      messagingSenderId: "101719017879",
      appId: "1:101719017879:android:f7dd2b7d72bd5ecea8dcd2",
    ),
  );
  runApp(PerformanceTrackerApp());
}

class PerformanceTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/athlete-login': (context) => const AthleteLoginScreen(),
        '/coach-login': (context) => const CoachLoginScreen(),
        '/admin-login': (context) => const AdminLoginScreen(),
        '/create-account': (context) => const CreateAccountScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/athlete-dashboard': (context) => const AthleteDashboard(),
        '/coach-dashboard': (context) => const CoachDashboard(),
        '/admin-dashboard': (context) => const AdminDashboard(),
      },
    );
  }
}
