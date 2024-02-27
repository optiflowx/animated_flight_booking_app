// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/flight_info_tile.dart';
import '../../providers/view_provider.dart';

class FlightMoreInfo extends StatelessWidget {
  const FlightMoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return AnimatedContainer(
            height: ref.watch(viewProvider) != 1 ? 80 : 60,
            duration: const Duration(milliseconds: 500),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 15), blurRadius: 20),
            ]),
            padding: EdgeInsets.symmetric(
                vertical: ref.watch(viewProvider) != 1 ? 10 : 0,
                horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child:
                  ref.watch(viewProvider) != 1 ? MoreInfoRow() : PaymentText(),
            ));
      },
    );
  }

  Widget PaymentText() {
    return const Center(
      child: Text(
        'SELECT PAYMENT METHOD',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget MoreInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        FlightInfoTile(
          title: 'Flight',
          info: 'AR 580',
        ),
        FlightInfoTile(
          title: 'Class',
          info: 'Premium\nEconim',
        ),
        FlightInfoTile(
          title: 'Aircraft',
          info: 'AR 580',
        ),
        FlightInfoTile(
          title: 'Possibility',
          info: 'AR 580',
        ),
      ],
    );
  }
}
