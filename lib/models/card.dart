import 'dart:ui';

class CreditCard {
  double rotation, position, opacity, scale;
  String name, bankLogo, cardType;
  Color beginColor, endColor;
  int cardNumber;

  CreditCard({
    this.opacity = 0.0,
    this.position = 0.0,
    this.rotation = 0.0,
    this.scale = 0.0,
    required this.name,
    required this.cardNumber,
    required this.beginColor,
    required this.endColor,
    required this.bankLogo,
    required this.cardType,
  });
}
