// View of Homepage and miniapp icons
import 'package:flutter/material.dart';
import '../shared/layout.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            // AppIcons
            AppIcon(
              iconData: Icons.bed_rounded,
              onTap: () => Navigator.pushNamed(context, '/sleep'),
            ),
            AppIcon(
              iconData: Icons.star,
              onTap: () => Navigator.pushNamed(context, '/bestof'),
            ),
            AppIcon(
              iconData: Icons.auto_fix_high,
              onTap: () => Navigator.pushNamed(context, '/routines'),
            ),
            // End of AppIcons
          ],
        ),
      ),
    );
  }
}
