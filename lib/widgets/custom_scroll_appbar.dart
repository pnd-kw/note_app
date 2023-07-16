import 'package:flutter/material.dart';

class CustomScrollAppBar extends StatelessWidget {
  const CustomScrollAppBar({
    super.key,
    required this.actions,
    required this.title,
    this.sliverFillRemaining,
    this.sliverPadding,
  });

  final List<Widget> actions;
  final Widget title;
  final Widget? sliverFillRemaining;
  final Widget? sliverPadding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.background),
          backgroundColor: Theme.of(context).colorScheme.primary,
          expandedHeight: 150,
          pinned: true,
          actions: actions,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: title,
            background: Image.asset(
              'assets/images/header-image.webp',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: sliverPadding,
        ),
        SliverFillRemaining(
          child: sliverFillRemaining,
        ),
      ],
    );
  }
}
