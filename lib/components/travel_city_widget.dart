import 'package:flutter/material.dart';

class TravelCityWidget extends StatelessWidget {
  final String city, cityAbbr, date;
  final CrossAxisAlignment alignment;

  const TravelCityWidget({
    Key? key,
    required this.city,
    required this.cityAbbr,
    required this.date,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Text(
          city,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        Text(
          cityAbbr,
          style: const TextStyle(color: Colors.white, fontSize: 32),
        ),
        Text(
          date,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        )
      ],
    );
  }
}
