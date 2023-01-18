import 'package:flutter/material.dart';
import 'ui/shared/colors.dart';

// Imports of View
import 'ui/views/home.dart';
// End of Imports of View

// Definition of MaterialApp() and routes of the app
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Example',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: colorScheme.toTheme,
        routes: {
          '/': (context) => const HomeView(),
        });
  }
}

