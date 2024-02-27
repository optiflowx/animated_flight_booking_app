import 'dart:ui';
import '../generated/assets.dart';
import '../models/card.dart';

class Cards {
  static List<CreditCard> data = [
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 9945,
      beginColor: const Color.fromARGB(255, 234, 94, 190),
      endColor: const Color.fromARGB(255, 224, 63, 92),
      bankLogo: Assets.assetsMarcusLogo,
      cardType: Assets.assetsMastercard,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 2670,
      beginColor: const Color.fromARGB(255, 171, 51, 75),
      endColor: const Color.fromARGB(255, 171, 51, 51),
      bankLogo: Assets.assetsVirgin,
      cardType: Assets.assetsMastercard,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 1239,
      beginColor: const Color.fromARGB(255, 25, 25, 25),
      endColor: const Color.fromARGB(255, 10, 10, 10),
      bankLogo: Assets.assetsAmericanExpress,
      cardType: Assets.assetsVisa,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 4587,
      beginColor: const Color.fromARGB(225, 126, 184, 253),
      endColor: const Color.fromARGB(255, 172, 157, 252),
      bankLogo: Assets.assetsDelta,
      cardType: Assets.assetsVisa,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 8765,
      beginColor: const Color.fromARGB(255, 162, 184, 253),
      endColor: const Color.fromARGB(255, 89, 89, 90),
      bankLogo: Assets.assetsAmericanExpress,
      cardType: Assets.assetsVisa,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 4301,
      beginColor: const Color.fromARGB(255, 25, 25, 25),
      endColor: const Color.fromARGB(255, 10, 10, 10),
      bankLogo: Assets.assetsAmericanExpress,
      cardType: Assets.assetsVisa,
    ),
    CreditCard(
      name: 'PRINCE B',
      cardNumber: 2135,
      beginColor: const Color.fromARGB(255, 171, 51, 75),
      endColor: const Color.fromARGB(255, 171, 51, 51),
      bankLogo: Assets.assetsVirgin,
      cardType: Assets.assetsMastercard,
    ),
  ];
}
