import 'package:flutter/material.dart';

class AnimatedBackgroundView extends StatelessWidget {
  const AnimatedBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 350),
            curve: Curves.easeIn,
            duration: const Duration(seconds: 2),
            builder: (context, height, _) {
              return Expanded(
                flex: 5,
                child: Container(
                  height: height,
                  color: Colors.blue.shade900,
                ),
              );
            },
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      );
  }
}