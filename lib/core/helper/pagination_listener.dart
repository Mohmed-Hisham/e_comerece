import 'package:flutter/material.dart';

class PaginationListener extends StatelessWidget {
  final Widget child;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final Axis scrollDirection;
  final bool fetchAtEnd;
  final double threshold;

  const PaginationListener({
    super.key,
    required this.child,
    required this.onLoadMore,
    this.isLoading = false,
    this.scrollDirection = Axis.vertical,
    this.fetchAtEnd = false,
    this.threshold = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {
          if (scrollInfo.metrics.axis == scrollDirection) {
            if (!isLoading) {
              final pixels = scrollInfo.metrics.pixels;
              final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;

              if (fetchAtEnd) {
                // Trigger only at the absolute edge
                if (scrollInfo.metrics.atEdge && pixels == maxScrollExtent) {
                  onLoadMore();
                }
              } else {
                // Trigger before reaching the end based on threshold
                if (pixels >= maxScrollExtent - threshold && pixels > 0) {
                  onLoadMore();
                }
              }
            }
          }
        }
        return false;
      },
      child: child,
    );
  }
}
