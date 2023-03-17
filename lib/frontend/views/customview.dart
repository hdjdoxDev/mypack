import 'package:flutter/material.dart';

import '../viewmodels/viewmodel.dart';
import 'view.dart';

/// A custom view that offers often used features.
/// 
/// This view is a wrapper around [IView] and [Scaffold].
/// 
/// It offers the following features:
/// - [title] as [AppBar] title
/// - [leading] as [AppBar] leading
/// - [actions] as [AppBar] actions
/// - [onTapBar] as [AppBar] onTap
/// - [onDoubleTapBar] as [AppBar] onDoubleTap
/// - [bottomSheet] as [Scaffold] bottomSheet
/// - [floatingActionButton] as [Scaffold] floatingActionButton
/// - [loading] as [IView] loading
/// - [initModel] as [IView] initModel
///   
/// The [body] is the only required parameter.
/// 
/// The [body] is a function that takes the [BuildContext], the [Model] and the [child] as parameters.

class CustomView<Model extends IModel> extends StatelessWidget {
  const CustomView({
    super.key,
    required this.body,
    this.initModel,
    this.title,
    this.onTapBar,
    this.onDoubleTapBar,
    this.actions,
    this.leading,
    this.loading,
    this.bottomSheet,
    this.floatingActionButton,
  });

  final Widget Function(
    BuildContext context,
    Model model,
    Widget? child,
  ) body;
  final void Function(Model)? initModel;
  final String? title;
  final void Function(Model)? onTapBar;
  final void Function(Model)? onDoubleTapBar;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? loading;
  final Widget Function(Model)? bottomSheet;
  final Widget Function(Model)? floatingActionButton;
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
        body: body(context, model, child),
        bottomSheet: bottomSheet != null ? bottomSheet!(model) : null,
        floatingActionButton:
            floatingActionButton != null ? floatingActionButton!(model) : null,
      ),
    );
  }
}

/// A custom [AppBar] that can be tapped.
/// 
/// This widget is a wrapper around [GestureDetector] and [AppBar].
/// 
/// It offers the following features:
/// 
/// - [onTap] as [GestureDetector] onTap
/// - [onDoubleTap] as [GestureDetector] onDoubleTap
/// - [appBar] as [GestureDetector] child
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
