import 'package:flutter/cupertino.dart';
import 'package:mypack/frontend/frontend.dart';

const String title = 'Eg';

class EgView extends StatelessWidget {
  const EgView({super.key});

  @override
  Widget build(BuildContext context) {
    return IView<IModel>(
      builder: (context, model, child) => CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text(title),
        ),
        child: Center(child: Text("${model.state}")),
      ),
    );
  }
}
