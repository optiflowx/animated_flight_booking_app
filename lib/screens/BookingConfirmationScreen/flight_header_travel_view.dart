import 'package:flutter/material.dart';

import '../../components/travel_city_widget.dart';
import '../../generated/assets.dart';

class FlightHeaderTravelView extends StatelessWidget {
  const FlightHeaderTravelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(65),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TravelCityWidget(
                alignment: CrossAxisAlignment.start,
                city: 'Los Angeles',
                cityAbbr: 'LAS',
                date: '24 Apr, 16:30',
              ),
              Column(
                children: const [
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white, size: 24),
                  SizedBox(height: 10),
                  Text(
                    '4h 15m',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                ],
              ),
              const TravelCityWidget(
                alignment: CrossAxisAlignment.end,
                city: 'New York City',
                cityAbbr: 'NYC',
                date: '20:45',
              ),
            ],
          ),
          Transform.scale(
            scale: 0.9,
            child: Hero(
              tag: '__Flight__',
              child: Image.asset(Assets.assetsAirplane),
            ),
          ),
        ],
      ),
    );
  }
}
