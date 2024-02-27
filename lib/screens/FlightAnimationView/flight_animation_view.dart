import 'dart:math' as math;

import 'package:animated_flight_booking_app/screens/BookingConfirmationScreen/booking_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/assets.dart';
import '../../providers/flight_animation_providers.dart';
import 'animated_ripple_effect.dart';
import 'large_cloud_animation.dart';
import 'small_cloud_animation.dart';

class FlightAnimationView extends ConsumerStatefulWidget {
  const FlightAnimationView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FlightAnimationViewState();
}

class _FlightAnimationViewState extends ConsumerState<FlightAnimationView>
    with TickerProviderStateMixin {
  //Controllers
  late final AnimationController flightController;
  late final AnimationController flightShadowController;

  late final Animation<double> translateXAnimation;
  late final Animation<double> translateYAnimation;
  late final Animation<double> rotateZAnimation;
  late final Animation<double> scaleAnimation;

  final List<String> texts = [
    "Connected...",
    "Secure payment...",
    "Secure payment...",
    "Purchased"
  ];

  void onAnimationDelay(int index) {
    const Duration delay = Duration(milliseconds: 4500);
    const Duration delayTransition = Duration(seconds: 11);

    if (index == 0) {
      Future.delayed(delay, () {
        ref.read(flyAnimationIndexProvider.notifier).state = 1;
      });
    } else if (index == 1) {
      Future.delayed(delay, () {
        ref.read(flyAnimationIndexProvider.notifier).state = 2;
        //Exactly after the state is changed,we start the animations.
        flightController.forward();
        flightShadowController.forward();
      });
    } else if (index == 2) {
      Future.delayed(delay, () {
        ref.read(flyAnimationIndexProvider.notifier).state = 3;
      });
    } else if (index == 3) {
      if (!flightController.isAnimating) {
        Future.delayed(delayTransition, () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1200),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                    opacity: animation,
                    child: const BookingConfirmationScreen());
              },
            ),
          );
        });
      }
    }
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      //After rotating to the angle of 25, we reverse the animation back to 0.
      Future.delayed(const Duration(milliseconds: 4000), () {
        flightController.reverse();
      });
    }
  }

  @override
  void initState() {
    const Duration duration = Duration(milliseconds: 3500);
    const Duration reverseDuration = Duration(milliseconds: 4500);

    flightController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: reverseDuration,
    )..addStatusListener(animationStatusListener);

    flightShadowController = AnimationController(
      vsync: this,
      duration: duration,
    );

    ///We do not reverse these animations, hence they haves their own controller.
    translateXAnimation =
        Tween<double>(begin: 0.0, end: -500.0).animate(flightShadowController);
    translateYAnimation =
        Tween<double>(begin: 0.0, end: 120.0).animate(flightShadowController);

    ///Why is it controlled by the shadow [AnimationController]?
    ///Well, due to the scale of the flight not being returned to back [1.0],
    ///We use the flight [AnimationController] because it is never reversed
    ///When the flight [AnimationStatus] is completed.
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(flightShadowController);

    //
    rotateZAnimation =
        Tween<double>(begin: 0.0, end: -20.0).animate(flightController);

    super.initState();
  }

  @override
  void dispose() {
    flightController.dispose();
    flightShadowController.dispose();
    flightController.removeStatusListener(animationStatusListener);
    super.dispose();
  }

  Future<bool> onWillPop() async {
      return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.vertical;
    final index = ref.watch(flyAnimationIndexProvider);
    onAnimationDelay(index);

    return WillPopScope(
      onWillPop: onWillPop,
      child: TweenAnimationBuilder(
        tween: ColorTween(begin: Colors.white, end: Colors.grey.shade300),
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        builder: (context, color, _) {
          return Scaffold(
            key: const Key('Flight Animation View'),
            backgroundColor: color,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  //Flight Shadow
                  AnimatedBuilder(
                    animation: flightShadowController,
                    builder: (context, child) {
                      return Positioned(
                        top: (MediaQuery.of(context).size.height * 0.2),
                        left: 15,
                        right: 15,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateZ(math.pi / 180 * rotateZAnimation.value)
                            ..scale(scaleAnimation.value)
                            ..translate(
                              translateXAnimation.value,
                              translateYAnimation.value,
                            ),
                          child: Image.asset(
                            Assets.assetsAirplane,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),

                  //Small Cloud
                  const SmallCloudAnimation(),

                  //Actual Flight
                  Positioned(
                    top: (MediaQuery.of(context).size.height * 0.2),
                    left: 15,
                    right: 15,
                    child: AnimatedBuilder(
                      animation: flightController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateZ(math.pi / 180 * rotateZAnimation.value)
                            ..scale(scaleAnimation.value),
                          child: Hero(
                            tag: '__Flight__',
                            child: Image.asset(Assets.assetsAirplane),
                          ),
                        );
                      },
                    ),
                  ),

                  ///Large Cloud Animation
                  const LargeCloudAnimation(),

                  //BottomViewAnimationWithRipples
                  const AnimatedRippleEffect(),

                  //Animated Text
                  Positioned(
                    bottom:
                        (MediaQuery.of(context).size.height * 0.24) + padding,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: Text(
                          texts[index],
                          key: Key(texts[index]),
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
