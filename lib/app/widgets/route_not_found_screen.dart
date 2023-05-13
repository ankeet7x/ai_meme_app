import 'package:flutter/material.dart';

class RouteNotFoundScreen extends StatelessWidget {
  static const String pageUrl = "/route-not-found-screen";
  const RouteNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("404 not found."),
      ),
    );
  }
}
