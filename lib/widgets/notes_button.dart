import 'package:flutter/material.dart';

class NotesButton extends StatelessWidget {
  const NotesButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final void Function() onPressed;
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
        foregroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
