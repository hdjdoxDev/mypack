import 'package:flutter/material.dart';

import 'routes.dart';

const String title = "App title";

class EgApp extends StatelessWidget {
  const EgApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
      ),
      initialRoute: EgRoutes.home,
      routes: EgRoutes.routes,
    );
  }
}
