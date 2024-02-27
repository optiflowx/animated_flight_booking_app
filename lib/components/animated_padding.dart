import 'package:flutter/material.dart';

class AnimatedPaddingWidget extends StatefulWidget {
  const AnimatedPaddingWidget({
    super.key,
    required this.padding,
    required this.child,
    required this.onTap,
    this.onAnimatePadding,
  });

  final double padding;

  final Widget child;

  final void Function(double)? onAnimatePadding;

  final VoidCallback onTap;

  @override
  State<AnimatedPaddingWidget> createState() => _AnimatedPaddingWidgetState();
}

class _AnimatedPaddingWidgetState extends State<AnimatedPaddingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 120),
    );

    _animation = _controller.drive(
      CurveTween(curve: Curves.easeIn),
    );

    if (widget.onAnimatePadding != null) {
      _animation.addListener(_onSqueeze);
    }
  }

  @override
  void dispose() {
    if (widget.onAnimatePadding != null) {
      _animation.removeListener(_onSqueeze);
    }

    _controller.dispose();

    super.dispose();
  }

  void _onSqueeze() {
    widget.onAnimatePadding?.call(_animation.value * widget.padding);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _controller.forward();
      },
      onTapUp: (details) async {
        if (!_animation.isCompleted) {
          Future<dynamic>.delayed(const Duration(milliseconds: 150), () {
            _controller.reverse();
          });
        }
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        child: widget.child,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: widget.padding * (1 - _animation.value),
            ),
            child: Transform.scale(
              scale: 1 - (_animation.value * widget.padding * 0.01),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
