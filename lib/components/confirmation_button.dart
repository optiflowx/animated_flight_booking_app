import 'package:animated_flight_booking_app/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/view_provider.dart';
import '../screens/FlightAnimationView/flight_animation_view.dart';
import 'animated_padding.dart';

class ConfirmationButton extends ConsumerWidget {
  ConfirmationButton({Key? key}) : super(key: key);

  final List<BoxShadow> boxShadow = [
    BoxShadow(
      color: const Color(0xFF4995FE).withOpacity(0.6),
      offset: const Offset(0, 8),
      blurRadius: 10,
    )
  ];

  final LinearGradient linearGradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF6E8DFF), Color(0xFF4995FE)],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(viewProvider);

    return AnimatedPaddingWidget(
      padding: 8,
      onTap: () {
        if (currentView == 0) {
          //Second View[Payment]
          ref.read(viewProvider.notifier).state = 1;
        } else if (currentView == 1) {
          //Airplane Animation
          ref.read(viewProvider.notifier).state = 2;

          Future.delayed(const Duration(milliseconds: 900), () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 800),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                      opacity: animation, child: const FlightAnimationView());
                },
              ),
            );
          });
        } else if (currentView == 2) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 750),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                    opacity: animation, child: const HomeScreen());
              },
            ),
          );
          // //This will init the animation
          ref.read(viewProvider.notifier).state = 0;
        }
      },
      child: Container(
        height: 42,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: linearGradient,
          boxShadow: boxShadow,
        ),
        child: Text(
          currentView == 2 ? 'Go to Home Screen' : 'Confirm \$1,536.00',
          style: const TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
