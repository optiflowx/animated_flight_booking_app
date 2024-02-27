import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/button_navigation_view.dart';
import 'animated_background.dart';
import 'flight_header_travel_view.dart';
import 'flight_header_content_view.dart';

class BookingConfirmationScreen extends ConsumerWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.of(context).padding.top;

    Future<bool> onWillPop() async {
      return Future.value(false);
  }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
         key: const Key('Booking Confirmation Screen'),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //Base is at the top
            const AnimatedBackgroundView(),

            Positioned(
              top: topPadding + 10,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  'Swipe down to see options',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ),

            Positioned(
              top: topPadding + 60,
              left: 25,
              right: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 20),
                  child: Container(
                    color: Colors.white.withAlpha(35),
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: const [
                      FlightHeaderContentView(),
                      FlightHeaderTravelView(),
                    ]),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Total Price:',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    '\$1,536.00',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
        bottomNavigationBar: const ButtonNavigationView(),
      ),
    );
  }
}
