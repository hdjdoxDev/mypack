import 'package:flutter/cupertino.dart';

import 'cupertinohomeview.dart';
// import 'materialview.dart';

const platform = TargetPlatform.iOS;

class EgRoutes {
  static const String home = '/';
  // static const String eg = '/eg';

  static Map<String, Widget Function(BuildContext)> get routes => {
        home: (context) => const EgHomeView(),
        // ...EgRoutes.routes.map((key, value) => MapEntry("$eg$key", value)),
        // clothes: (context) => const ClothesView(),
      };

  static get pathsFromHome => [
        // eg,
      ];
}
