import 'dart:ui';

import 'package:flutter/material.dart';

class RippleContainer extends StatelessWidget {
  final double scale;

  const RippleContainer({
    Key? key,
    required this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withAlpha(150),
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 4.5, blurRadius: 3.0)
        ],
      ),
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..scale(scale),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: const SizedBox(height: 80, width: 80),
        ),
      ),
    );
  }
}
