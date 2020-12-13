import 'package:flutter/material.dart';
import 'package:self_improvement/screens/splashScreen.dart';
import 'package:self_improvement/screens/homeScreen.dart';
import 'package:self_improvement/screens/lifeHackScreen.dart';
import 'package:self_improvement/screens/entrepreneurshipScreen.dart';
import 'package:self_improvement/screens/selfImprovementScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Self Improvement',
      initialRoute: '/',
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/lifeHack': (context) => LifeHackScreen(),
        '/entrepreneurship': (context) => EntrepreneurshipScreen(),
        '/selfImp': (context) => SelfImprovementScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightGreen,
        accentColor: Colors.white,
      ),
    );
  }
}
