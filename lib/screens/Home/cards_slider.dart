// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/credit_card.dart';
import '../../data/cards.dart';
import '../../models/card.dart';

class CardsSlider extends ConsumerStatefulWidget {
  const CardsSlider({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CardsSliderState();
}

class _CardsSliderState extends ConsumerState<CardsSlider> {
  List<CreditCard> cards = Cards.data;
  late final double startPosition, endPosition;
  late double scrollOffsetY, outsideCardInterval, initialArea;

  // List<Widget> CardsView() {
  //   List<Widget> widgetStack = [];
  //
  //   for (int index = 0; index < cards.length; index++) {
  //     CreditCard creditCard = cards[index];
  //
  //     widgetStack.add(CreditCardWidget(
  //       bankLogo: creditCard.bankLogo,
  //       cardType: creditCard.cardType,
  //       cardNumber: creditCard.cardNumber,
  //       beginColor: creditCard.beginColor,
  //       endColor: creditCard.endColor,
  //       cardOwner: creditCard.name,
  //       position: creditCard.position,
  //       scale: creditCard.scale,
  //       rotation: creditCard.rotation,
  //       opacity: creditCard.opacity,
  //     ));
  //   }
  //
  //   return widgetStack;
  // }

  @override
  void initState() {
    super.initState();

    scrollOffsetY = 0.0;
    outsideCardInterval = 30.0;
    startPosition = 0;
    endPosition = 180;
    initialArea = endPosition - startPosition;

    for (int index = 0; index < cards.length; index++) {
      CreditCard creditCard = cards[index];

      //Why divide in this notation? LOL, this should be quite obvious.
      final opacity = 0.9 - (index - 1) * 0.1;
      final position = endPosition + ((index - 1) * 30);
      const rotation = -70.0;

      //If index is at the initial position
      if (index == 0) {
        creditCard.scale = 1.0;
        creditCard.rotation = 0.0;
        creditCard.position = startPosition;
        creditCard.opacity = 1.0;
      } else {
        creditCard.scale = 0.95;
        creditCard.rotation = rotation;
        creditCard.position = position;
        creditCard.opacity = opacity;
      }
    }

    cards = cards.reversed.toList();
  }

  positionUpdate(double currentOffset) {
    void updateInitialCardPosition(CreditCard card, double value, int index) {
      card.position += currentOffset;

      double currentCardAtAtrealdx = value + index;
      final double positionDifference = (endPosition - startPosition);
      final double upPositionDifference = (startPosition - card.position);
      final double downPositionDifference = (card.position - startPosition);

      if (currentCardAtAtrealdx < 0) {
        card.position =
            startPosition + currentCardAtAtrealdx * outsideCardInterval;

        //Rotation
        card.rotation = -90.0 / outsideCardInterval * upPositionDifference;
        if (card.rotation > 0.0) card.rotation = 0.0;
        if (card.rotation < -90.0) card.rotation = -90.0;

        //Scale
        card.scale = 1.0 - 0.2 / outsideCardInterval * upPositionDifference;
        if (card.scale < 0.8) card.scale = 0.8;
        if (card.scale > 1.0) card.scale = 1.0;

        // //1.0->0.7 Opacity
        card.opacity = 1.0 - 0.7 / outsideCardInterval * upPositionDifference;
        if (card.opacity < 0.0) card.opacity = 0.0;
        if (card.opacity > 1.0) card.opacity = 1.0;
      } else if (currentCardAtAtrealdx >= 0 && currentCardAtAtrealdx < 1) {
        card.position = startPosition + currentCardAtAtrealdx * initialArea;

        card.rotation = -70.0 / positionDifference * downPositionDifference;
        if (card.rotation > 0.0) card.rotation = 0.0;
        if (card.rotation < -70.0) card.rotation = -70.0;

        card.scale = 1.0 - 0.125 / positionDifference * downPositionDifference;
        if (card.scale < 0.95) card.scale = 0.95;
        if (card.scale > 1.0) card.scale = 1.0;

        // //1.0->0.7
        card.opacity =
            1.0 - 0.3 / positionDifference * downPositionDifference; //CHECK
        if (card.opacity < 0.0) card.opacity = 0.0;
        if (card.opacity > 1.0) card.opacity = 1.0;
      } else if (currentCardAtAtrealdx >= 1) {
        card.position =
            endPosition + (currentCardAtAtrealdx - 1) * outsideCardInterval;
        card.rotation = -70.0;
        card.scale = 0.95;
        card.opacity = 0.75;
      }
    }

    scrollOffsetY += currentOffset;
    double firstCardAtArealdx = scrollOffsetY / initialArea;

    for (var i = 0; i < cards.length; i++) {
      CreditCard card = cards[cards.length - 1 - i];
      updateInitialCardPosition(card, firstCardAtArealdx, i);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (dragUpdate) {
        positionUpdate(dragUpdate.delta.dy);
      },
      onVerticalDragEnd: (details) {
        scrollOffsetY = (scrollOffsetY / initialArea).round() * initialArea;
        positionUpdate(0);
      },
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: List.generate(cards.length, (index) {
            CreditCard creditCard = cards[index];

            return CreditCardWidget(
              bankLogo: creditCard.bankLogo,
              cardType: creditCard.cardType,
              cardNumber: creditCard.cardNumber,
              beginColor: creditCard.beginColor,
              endColor: creditCard.endColor,
              cardOwner: creditCard.name,
              position: creditCard.position,
              scale: creditCard.scale,
              rotation: creditCard.rotation,
              opacity: creditCard.opacity,
            );
          }),
        ),
      ),
    );
  }
}
