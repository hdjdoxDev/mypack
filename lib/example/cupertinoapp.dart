import 'package:flutter/cupertino.dart';

import 'routes.dart';

const String title = "App title";

class EgApp extends StatelessWidget {
  const EgApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemYellow,
      ),
      initialRoute: EgRoutes.home,
      routes: EgRoutes.routes,
    );
  }
}
