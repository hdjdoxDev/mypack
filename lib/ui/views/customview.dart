import 'package:flutter/material.dart';

import '../../core/viewmodels/viewmodel.dart';
import 'view.dart';

class CustomView<Model extends IModel> extends StatelessWidget {
  const CustomView({
    super.key,
    required this.builder,
    this.initModel,
    this.title,
    this.onTapBar,
    this.onDoubleTapBar,
    this.actions,
    this.leading,
    this.loading,
  });

  final Widget Function(
    BuildContext context,
    Model model,
    Widget? child,
  ) builder;
  final void Function(Model)? initModel;
  final String? title;
  final void Function(Model)? onTapBar;
  final void Function(Model)? onDoubleTapBar;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return IView<Model>(
      initModel: initModel,
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
            leading: leading ?? const BackButton(),
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