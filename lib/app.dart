import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.home,
  });
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home);
  }
}
