import 'package:flutter/material.dart';
import 'package:free_vpn/initial_view.dart';

void main() => runApp(MainProgram());

class MainProgram extends StatelessWidget {
  const MainProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: InitialView());
  }
}
