import 'package:flutter/material.dart';
import 'package:mypack/example/materialapp.dart';
import 'package:mypack/ui/shared/layout.dart';

import 'routes.dart';

class EgView extends StatelessWidget {
  const EgView({super.key});

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
