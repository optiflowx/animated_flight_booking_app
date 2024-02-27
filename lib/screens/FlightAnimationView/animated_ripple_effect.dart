// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'ripple_container.dart';
import '../../providers/flight_animation_providers.dart';

class AnimatedRippleEffect extends ConsumerStatefulWidget {
  const AnimatedRippleEffect({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AnimatedRippleEffectState();
}

class _AnimatedRippleEffectState extends ConsumerState<AnimatedRippleEffect>
    with TickerProviderStateMixin {
  late final AnimationController animationControllerBig;
  late final Animation<double> scaleAnimationBig;
  late final AnimationController animationControllerMedium;
  late final Animation<double> scaleAnimationMedium;

  final List<Map> animationProps = [
    {
      'icon': Ionicons.md_wifi,
      'color': Colors.grey.shade400,
      'size': 45.0,
    },
    {
      'icon': Ionicons.link_sharp,
      'color': Colors.grey.shade400,
      'size': 45.0,
    },
    {
      'icon': Ionicons.shield_checkmark_outline,
      'color': Colors.grey.shade400,
      'size': 45.0,
    },
    {
      'icon': Entypo.check,
      'color': Colors.black,
      'size': 50.0,
    },
  ];

  void onAnimateListener() {
    if (animationControllerBig.value == 0.65) {
      animationControllerMedium.forward();
    }
  }

  @override
  void initState() {
    const Duration duration = Duration(milliseconds: 2400);

    animationControllerBig = AnimationController(
        vsync: this, duration: duration, reverseDuration: duration)
      ..forward()
      ..repeat()
      ..addListener(onAnimateListener);

    animationControllerMedium = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    )..repeat();

    scaleAnimationBig = Tween<double>(begin: 1.25, end: 3.0).animate(
        CurvedAnimation(parent: animationControllerBig, curve: Curves.linear));

    scaleAnimationMedium = Tween<double>(begin: 0.35, end: 2.35).animate(
        CurvedAnimation(
            parent: animationControllerMedium, curve: Curves.linear));

    super.initState();
  }

  @override
  void dispose() {
    animationControllerBig.dispose();
    animationControllerMedium.dispose();
    animationControllerBig.removeListener(onAnimateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.vertical;
    return Positioned(
      bottom: (MediaQuery.of(context).size.height * 0.12) + (padding),
      left: 0,
      right: 0,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BigRippleContainer(),
            MediumRippleContainer(),
            InnerIconContainer(),
          ],
        ),
        builder: (context, animation, child) {
          return Transform.scale(
            scale: animation,
            child: Opacity(opacity: animation, child: child),
          );
        },
      ),
    );
  }

  Widget BigRippleContainer() {
    return AnimatedBuilder(
      animation: animationControllerBig,
      builder: (context, child) {
        return RippleContainer(scale: scaleAnimationBig.value);
      },
    );
  }

  Widget MediumRippleContainer() {
    return AnimatedBuilder(
      animation: animationControllerMedium,
      builder: (context, child) {
        return RippleContainer(scale: scaleAnimationMedium.value);
      },
    );
  }

  Widget InnerIconContainer() {
    final index = ref.watch(flyAnimationIndexProvider);

    return Container(
      height: 105,
      width: 105,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 12),
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(color: Colors.black26, spreadRadius: 4, blurRadius: 10),
        ],
      ),
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
        child: Icon(
          animationProps[index]['icon'],
          key: Key(animationProps[index]['icon'].toString()),
          size: animationProps[index]['size'],
          color: animationProps[index]['color'],
        ),
      ),
    );
  }
}
