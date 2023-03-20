import 'package:flutter/material.dart';
import 'package:mypack/frontend/frontend.dart';

import 'routes.dart';

const String title = "App title";

class EgHomeView extends StatelessWidget {
  const EgHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            for (final route in EgRoutes.pathsFromHome)
              MyIconButton(
                onTap: () => Navigator.pushNamed(context, route),
                iconData: EgRoutesIcons.icons[route]!,
              ),
          ],
        ),
      ),
    );
  }
}

extension EgRoutesIcons on EgRoutes {
  static const Map<String, IconData> icons = {
    EgRoutes.home: Icons.home,
    // EgRoutes.eg: Icons.eg,
  };
}
