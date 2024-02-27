import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flight_attendants_view.dart';

class FlightAttendantsContentView extends ConsumerStatefulWidget {
  const FlightAttendantsContentView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FlightAttendantsContentViewState();
}

class _FlightAttendantsContentViewState
    extends ConsumerState<FlightAttendantsContentView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: ClipRect(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Total duration: ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '43h 15m',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const FlightAttendantsView(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
