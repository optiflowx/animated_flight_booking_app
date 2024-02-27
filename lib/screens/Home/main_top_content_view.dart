import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/travel_city_widget.dart';
import '../../generated/assets.dart';

class MainTopContentView extends ConsumerStatefulWidget {
  const MainTopContentView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MainTopContentViewState();
}

class _MainTopContentViewState extends ConsumerState<MainTopContentView> {
  final radius = const Radius.circular(15);
  final gradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Colors.blue.shade300,
      Colors.blue.shade900,
      Colors.blue.shade900,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        gradient: gradient,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.assetsLogo,
            height: 35,
          ),
          const SizedBox(height: 25),
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
        ],
      ),
    );
  }
}
