import 'package:flutter/material.dart';

class SliverSpacer extends StatelessWidget {
  final double height;
  const SliverSpacer(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height));
  }
}
