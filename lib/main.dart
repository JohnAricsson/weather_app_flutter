import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

//we use the following packages
// geolocator: ^14.0.2
// weather: ^3.2.1
// intl: ^0.20.2
// flutter_bloc: ^9.1.1
// equatable: ^2.0.8
// cupertino_icons: ^1.0.8
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
