import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static FavoriteAnimationController get to => Get.find();

  late final AnimationController ctrl;
  late final Animation<double> scale;
  late final Animation<double> translateY;

  @override
  void onInit() {
    super.onInit();

    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
    ]).animate(ctrl);

    translateY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 60.0,
          end: -20.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -20.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 40,
      ),
    ]).animate(ctrl);

    ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) {}
    });
  }

  Future<void> play() async {
    ctrl.reset();
    await ctrl.forward();
  }

  @override
  void onClose() {
    ctrl.dispose();
    super.onClose();
  }
}

class FavoriteAnimatedWidget extends StatelessWidget {
  final double size;
  final VoidCallback? onEnd;

  const FavoriteAnimatedWidget({super.key, this.size = 100, this.onEnd});

  double _shake(double t) {
    final freq = 6.0;
    final damping = (1 - t);
    return sin(t * pi * freq) * 10.0 * damping;
  }

  @override
  Widget build(BuildContext context) {
    final c = FavoriteAnimationController.to;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: c.ctrl,
        builder: (context, child) {
          final t = c.ctrl.value;
          final scale = c.scale.value;
          final dy = c.translateY.value;
          final dx = _shake(t);

          if (t >= 1.0) {
            if (onEnd != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => onEnd!());
            }
          }

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: _buildGradientHeart(size),
      ),
    );
  }

  Widget _buildGradientHeart(double size) {
    return Center(
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFB74D), Colors.red],
          ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.srcIn,
        child: Icon(Icons.favorite, size: size, color: Colors.white),
      ),
    );
  }
}
