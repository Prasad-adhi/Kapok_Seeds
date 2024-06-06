import 'package:flutter/material.dart';
import 'OrgSignup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TextField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => OrgSignup(),
        // '/home': (context) => HomePage(),
        // '/profile': (context) => ProfilePage(),
      },
    );
  }
}



