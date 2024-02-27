import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/view_provider.dart';

class FlightAttendantsContentViewWrapper extends ConsumerStatefulWidget {
  final bool shouldKeepAlive;
  final Widget child;

  const FlightAttendantsContentViewWrapper({
    Key? key,
    this.shouldKeepAlive = false,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FlightAttendantsContentViewWrapperState();
}

class _FlightAttendantsContentViewWrapperState
    extends ConsumerState<FlightAttendantsContentViewWrapper>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;
  late final Animation<double> opacityAnimation;
  late final Animation<double> perspectiveAnimation;
  late final Animation<double> shadowRadiusAnimation;
  late final Animation<AlignmentGeometry> alignmentAnimation;
  late final Animation<EdgeInsetsGeometry> marginAnimation;

  @override
  void initState() {
    const double perspectiveValue = 0.0090;
    const Duration duration = Duration(milliseconds: 800);

    animationController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );

    scaleAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.easeIn),
      ),
    );

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.9, curve: Curves.easeIn),
      ),
    );

    shadowRadiusAnimation = Tween<double>(begin: 15, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    perspectiveAnimation = Tween<double>(
      begin: perspectiveValue,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    alignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.easeOut),
      ),
    );

    marginAnimation = Tween<EdgeInsetsGeometry>(
      begin: const EdgeInsets.only(top: 150),
      end: EdgeInsets.zero,
    ).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.shouldKeepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    //Listen to the changes of the button.
    if (ref.watch(viewProvider) == 0) {
      animationController.forward();
    } else if (ref.watch(viewProvider) != 0 || ref.watch(viewProvider) != 1) {
      animationController.reverse();
    }

    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            // margin: marginAnimation.value,
            transformAlignment: alignmentAnimation.value,
            transform: Matrix4.identity()
              ..setEntry(3, 1, perspectiveAnimation.value)
              ..scale(scaleAnimation.value, scaleAnimation.value),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: shadowRadiusAnimation.value,
                spreadRadius: shadowRadiusAnimation.value,
              )
            ]),
            child: child,
          ),
        );
      },
    );
  }
}
