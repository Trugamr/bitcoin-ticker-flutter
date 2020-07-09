import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(initialRoute: '/home', routes: {
      '/home': (context) => HomeScreen(),
    }),
  );
}
