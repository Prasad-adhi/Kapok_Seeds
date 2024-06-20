import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'OrgSignup.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import "Users.dart";

Future<Map<String, String>> readConfigFile() async {
  final configString = await rootBundle.loadString('assets/firebase_config.txt');
  final configLines = LineSplitter.split(configString);
  final configMap = <String, String>{};

  for (var line in configLines) {
    final keyValue = line.split(':');
    if (keyValue.length >= 2) {
      final key = keyValue[0].trim();
      final value = keyValue.sublist(1).join(':').trim();
      configMap[key] = value;
    }
  }

  return configMap;
}



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final config = await readConfigFile();
    if(kIsWeb)
    {
      await Firebase.initializeApp(
          options: FirebaseOptions(
          apiKey: config['apiKey']!,
          appId: config['appId']!,
          messagingSenderId: config['messagingSenderId']!,
          projectId: config['projectId']!,
        )
      );
    }

  await Firebase.initializeApp();
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



