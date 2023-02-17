import 'package:flutter/material.dart';
import 'base_view.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      initModel: (model) => {},
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(child: Column(children: const [])),
      ),
    );
  }
}
