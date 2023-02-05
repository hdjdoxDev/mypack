import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/base_viewmodel.dart';
import '../../locator.dart';
import '../shared/errors.dart';

class BaseView<Model extends BaseModel> extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    Model model,
    Widget? child,
  ) builder;
  final Widget? loading;
  final Function(Model)? onModelReady;
  const BaseView(
      {super.key, required this.builder, this.onModelReady, this.loading});

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
            ? widget.loading ?? const Loading()
            : widget.builder(context, model, child),
      ),
    );
  }
}

class CustomView<Model extends BaseModel> extends StatelessWidget {
  const CustomView({
    super.key,
    required this.builder,
    this.onModelReady,
    this.title,
    this.onTapBar,
    this.onDoubleTapBar,
    this.actions,
    this.loading,
  });

  final Widget Function(
    BuildContext context,
    Model model,
    Widget? child,
  ) builder;
  final void Function(Model)? onModelReady;
  final String? title;
  final void Function(Model)? onTapBar;
  final void Function(Model)? onDoubleTapBar;
  final List<Widget>? actions;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return BaseView<Model>(
      onModelReady: onModelReady,
      loading: loading,
      builder: (context, model, child) => Scaffold(
        appBar: TappableAppBar(
          onTap: onTapBar != null ? () => onTapBar!(model) : () => {},
          onDoubleTap:
              onDoubleTapBar != null ? () => onDoubleTapBar!(model) : () => {},
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              title ?? 'Custom View',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: actions ?? [],
          ),
        ),
        body: builder(context, model, child),
      ),
    );
  }
}

class TappableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final AppBar appBar;

  const TappableAppBar(
      {super.key,
      required this.onTap,
      required this.onDoubleTap,
      required this.appBar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, onDoubleTap: onDoubleTap, child: appBar);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
