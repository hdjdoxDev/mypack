import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/base_viewmodel.dart';
import '../../locator.dart';
import '../shared/errors.dart';

class BaseView<Model extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, Model model, Widget? child)
      builder;
  final Function(Model)? onModelReady;
  final String? title;
  const BaseView(
      {super.key,
      required this.builder,
      this.onModelReady,
      this.title});

  @override
  State<BaseView<Model>> createState() => _BaseViewState<Model>();
}

class _BaseViewState<Model extends BaseModel> extends State<BaseView<Model>> {
  Model model = locator<Model>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>.value(
      value: model,
      child: Consumer<Model>(
        builder: (context, model, child) => model.state == ViewState.busy
            ? const Loading()
            : widget.builder(context, model, child),
      ),
    );
  }
}

class CustomView<Model extends BaseModel> extends StatelessWidget {
  const CustomView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Custom View"),
      ),
    );
  }
  

} 