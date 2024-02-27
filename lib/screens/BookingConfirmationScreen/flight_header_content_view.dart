import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class FlightHeaderContentView extends StatelessWidget {
  const FlightHeaderContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(Assets.assetsLogo, height: 20),
          const SizedBox(height: 20),
          const Text(
            'Your order has been submitted',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'We are waiting for booking confirmation',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
