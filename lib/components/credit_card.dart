import 'package:flutter/material.dart';
import 'dart:math' as math;

class CreditCardWidget extends StatelessWidget {
  final String cardOwner, bankLogo, cardType;
  final int cardNumber;
  final Color beginColor, endColor;
  final double scale, rotation, opacity, position;

  const CreditCardWidget({
    Key? key,
    required this.bankLogo,
    required this.cardType,
    required this.cardNumber,
    required this.beginColor,
    required this.endColor,
    required this.cardOwner,
    required this.position,
    required this.scale,
    required this.rotation,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      top: position,
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 150),
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: 170,
          width: w * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: [beginColor, endColor]),
          ),
          alignment: AlignmentDirectional.topCenter,
          transformAlignment: AlignmentDirectional.topCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX((math.pi / 180) * rotation)
            ..scale(scale),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 20,
                child: Image.asset(bankLogo, height: 35),
              ),
              Positioned(
                bottom: 15,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cardNumber',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cardOwner,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 25,
                child: Image.asset(cardType, height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
