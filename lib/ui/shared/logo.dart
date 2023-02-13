import 'package:flutter/material.dart';

class LogoView extends StatefulWidget {
  const LogoView({
    super.key,
    required this.title,
    required this.future,
    required this.routeName,
  });
  final String title;
  final Future future;
  final String routeName;

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  void initState() {
    widget.future
        .then((_) => Navigator.pushReplacementNamed(context, widget.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
