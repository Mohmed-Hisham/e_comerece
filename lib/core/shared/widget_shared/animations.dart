import 'package:flutter/material.dart';

class FadeScaleTransition extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  const FadeScaleTransition({
    Key? key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 380),
    this.curve = Curves.easeOutBack,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: visible ? 1 : 0,
      curve: Curves.easeIn,
      child: AnimatedScale(
        scale: visible ? 1.0 : 0.85,
        duration: duration,
        curve: curve,
        alignment: alignment,
        child: child,
      ),
    );
  }
}

class SlideUpFade extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Duration duration;
  final Curve curve;
  final double
  offsetY; // مقدار الابتعاد العمودي بالبداية (مثال: 0.25 = 25% of height)

  const SlideUpFade({
    Key? key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 420),
    this.curve = Curves.easeOut,
    this.offsetY = 0.18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : Offset(0, offsetY),
      duration: duration,
      curve: curve,
      child: AnimatedOpacity(
        duration: duration,
        opacity: visible ? 1 : 0,
        child: child,
      ),
    );
  }
}

class StaggeredPop extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Duration duration;
  final Curve curve;
  final double startScale;
  final double startRotation;

  const StaggeredPop({
    Key? key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.elasticOut,
    this.startScale = 0.6,
    this.startRotation = -0.15, // radians
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: visible ? 0.0 : 1.0, end: visible ? 1.0 : 0.0),
      duration: duration,
      curve: curve,
      builder: (context, value, w) {
        // clamp the animated value to [0,1] to avoid overshoot issues with elastic curves
        final double v = value.clamp(0.0, 1.0);

        // use v (0..1) for stable computations
        final scale = startScale + (1 - startScale) * v;
        final rot = startRotation * (1 - v);
        final opacity = v;

        return Opacity(
          opacity: opacity,
          child: Transform.rotate(
            angle: rot,
            child: Transform.scale(scale: scale, child: w),
          ),
        );
      },
      child: child,
    );
  }
}
