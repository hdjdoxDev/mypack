import 'package:flutter/material.dart';
import 'view.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IView(
      initModel: (model) => {},
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(),
        body: const SingleChildScrollView(child: Column(children: [])),
      ),
    );
  }
}
