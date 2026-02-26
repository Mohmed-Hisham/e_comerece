import 'package:flutter/material.dart';

/// A lazy version of [IndexedStack] that only builds children
/// when they are first selected, and keeps them alive after that.
/// Includes a subtle fade animation when switching tabs.
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack>
    with SingleTickerProviderStateMixin {
  late final List<bool> _activated;
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _activated = List.generate(
      widget.children.length,
      (i) => i == widget.index,
    );
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // curve side
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _animController.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_activated[widget.index]) {
      _activated[widget.index] = true;
    }
    if (oldWidget.index != widget.index) {
      _animController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: IndexedStack(
        index: widget.index,
        children: List.generate(widget.children.length, (i) {
          if (_activated[i]) {
            return widget.children[i];
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
