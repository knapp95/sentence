import 'package:flutter/material.dart';
import 'package:sentence/screens/core_value_screen.dart';

void main() {
  runApp(MyApp());
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.red,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: CoreValueScreen(),
    );
  }
}
