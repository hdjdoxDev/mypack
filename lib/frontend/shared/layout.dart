import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final Function() onTap;
  final IconData iconData;
  const AppIcon({required this.iconData, required this.onTap, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: onTap, child: Icon(iconData)),
      );
}

class PaddedColumn extends StatelessWidget {
  const PaddedColumn({required this.children, Key? key}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      for (var i in children) ...[
        Padding(
          padding: const EdgeInsets.all(8),
          child: i,
        )
      ]
    ]);
  }
}

class SeparatedRow extends StatelessWidget {
  const SeparatedRow({required this.children, Key? key}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (children.isNotEmpty) children[0],
      for (var i in children.skip(1)) ...[
        const SizedBox(width: 8),
        i,
      ]
    ]);
  }
}

class SeparatedColumn extends StatelessWidget {
  const SeparatedColumn({required this.children, Key? key}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (children.isNotEmpty) children[0],
      for (var i in children.skip(1)) ...[
        const SizedBox(height: 8),
        i,
      ]
    ]);
  }
}

class Header extends StatelessWidget {
  const Header(this.heading, {Key? key}) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {Key? key}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {Key? key}) : super(key: key);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class LabeledField extends StatelessWidget {
  const LabeledField({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label:',
            style: TextStyle(color: Colors.grey[700], fontSize: 10),
          ),
          Center(child: value),
        ],
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, Key? key})
      : super(key: key);
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2)),
        onPressed: onPressed,
        child: child,
      );
}

class CancelButton extends StatelessWidget {
  const CancelButton({this.onPressed, this.color, Key? key}) : super(key: key);
  final void Function()? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.cancel,
        color: color ?? Colors.red,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({this.onPressed, this.color, Key? key}) : super(key: key);
  final void Function()? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return StyledButton(
        onPressed: onPressed ?? () {},
        child: const Icon(Icons.cancel_outlined));
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.color = Colors.black,
    required this.iconData,
  });
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        padding: const EdgeInsets.all(10),
        child: Icon(iconData, color: color),
      ),
    );
  }
}

const Widget emptyWidget = SizedBox(width: 0, height: 0);

// confirmation dialog
Future<bool> showConfirmDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
  Widget? confirmLabel,
  Widget? cancelLabel,
}) async {
  final bool? isConfirm = await showDialog<bool>(
    context: context,
    builder: (_) => WillPopScope(
      child: AlertDialog(
        title: title,
        content:
            (content != null) ? content : const Text('Are you sure continue?'),
        actions: <Widget>[
          TextButton(
            child: cancelLabel ?? const Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: confirmLabel ?? const Text('Confirm'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
    ),
  );

  return (isConfirm != null) ? isConfirm : false;
}
