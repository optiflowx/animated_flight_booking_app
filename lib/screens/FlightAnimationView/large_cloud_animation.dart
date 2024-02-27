import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../generated/assets.dart';
import '../../providers/flight_animation_providers.dart';

class LargeCloudAnimation extends ConsumerStatefulWidget {
  const LargeCloudAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LargeCloudAnimationState();
}

class _LargeCloudAnimationState extends ConsumerState<LargeCloudAnimation>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController largeCloudController;
  late final Animation<double> translateXAnimation;

  @override
  void initState() {
    const Duration cloudsDuration = Duration(milliseconds: 3500);

    largeCloudController = AnimationController(
      vsync: this,
      duration: cloudsDuration,
    );

    translateXAnimation =
        Tween<double>(begin: 0.0, end: -950.0).animate(largeCloudController);

    super.initState();
  }

  @override
  void dispose() {
    largeCloudController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final int index = ref.watch(flyAnimationIndexProvider);

    if (index == 1) {
      Future.delayed(const Duration(milliseconds: 4500), () {
        largeCloudController.forward();
        largeCloudController.repeat();
      });
    }

    return Positioned(
      bottom: 0,
      left: 200,
      child: AnimatedBuilder(
        animation: largeCloudController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()..translate(translateXAnimation.value),
            child: Image.asset(Assets.assetsClouds,
                height: 620, fit: BoxFit.fitHeight),
          );
        },
      ),
    );
  }
}
