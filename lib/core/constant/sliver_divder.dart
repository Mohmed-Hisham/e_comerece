import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  final double height;
  const SliverDivider(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Divider(height: height));
  }
}
