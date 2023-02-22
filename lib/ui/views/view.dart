import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/viewmodel.dart';
import '../../locator.dart';
import '../shared/errors.dart';

class IView<Model extends IModel> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    Model model,
    Widget? child,
  ) builder;
  final Widget? loading;
  final Function(Model)? initModel;
  const IView({super.key, required this.builder, this.initModel, this.loading});

  @override
  State<IView<Model>> createState() => _IViewState<Model>();
}

class _IViewState<Model extends IModel> extends State<IView<Model>> {
  Model model = locator<Model>();

  @override
  void initState() {
    if (widget.initModel != null) {
      widget.initModel!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>.value(
      value: model,
      child: Consumer<Model>(
        builder: (context, model, child) => model.state == ViewState.busy
            ? widget.loading ?? const Loading()
            : widget.builder(context, model, child),
      ),
    );
  }
}
