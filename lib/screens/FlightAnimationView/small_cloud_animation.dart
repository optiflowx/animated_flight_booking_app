import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../generated/assets.dart';
import '../../providers/flight_animation_providers.dart';

class SmallCloudAnimation extends ConsumerStatefulWidget {
  const SmallCloudAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SmallCloudAnimationState();
}

class _SmallCloudAnimationState extends ConsumerState<SmallCloudAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController smallCloudController;
  late final Animation<double> translateXAnimation;

  @override
  void initState() {
    const Duration cloudsDuration = Duration(milliseconds: 4500);

    smallCloudController = AnimationController(
      vsync: this,
      duration: cloudsDuration,
    );

    translateXAnimation =
        Tween<double>(begin: 600.0, end: -350.0).animate(smallCloudController);

    super.initState();
  }

  @override
  void dispose() {
    smallCloudController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final index = ref.watch(flyAnimationIndexProvider);

    if (index == 1) {
      Future.delayed(const Duration(milliseconds: 4500), () {
        smallCloudController.forward();
        smallCloudController.repeat();
      });
    }

    return Positioned(
      top: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: smallCloudController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()..translate(translateXAnimation.value),
            child: Image.asset(Assets.assetsClouds,
                height: 280, fit: BoxFit.fitHeight),
          );
        },
      ),
    );
  }
}
