import 'package:event_connect/AdminScreen/AdminDashboard.dart';
import 'package:event_connect/AdminScreen/Admin_AttendeeList.dart';
import 'package:event_connect/AttendeeScreens/AttendeeDashboard.dart';
import 'package:event_connect/auth/SignIN.dart';
import 'package:event_connect/auth/SplashScreen.dart';
import 'package:event_connect/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
