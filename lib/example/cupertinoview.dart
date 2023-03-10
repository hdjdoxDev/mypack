import 'package:flutter/cupertino.dart';
import 'package:mypack/ui/shared/layout.dart';

import 'routes.dart';

const String title = 'Eg';

class EgView extends StatelessWidget {
  const EgView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Center(
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
    EgRoutes.home: CupertinoIcons.home,
    // EgRoutes.eg: CupertinoIcons.eg,
  };
}
