import 'package:animated_flight_booking_app/screens/Home/cards_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/button_navigation_view.dart';
import '../../generated/assets.dart';
import '../../providers/view_provider.dart';
import '../Wrappers/flight_attendants_content_view_wrapper.dart';
import '../Wrappers/top_views_wrapper.dart';
import 'flight_more_info.dart';
import 'main_bottom_content_view.dart';
import 'main_top_content_view.dart';
import '../Wrappers/cards_slider_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> onWillPop() async {
      return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top + 15;

    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
           key: const Key('Home Screen'),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.grey.shade300,
          body: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Padding(
                padding: EdgeInsets.only(top: top),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: ref.watch(viewProvider) != 1 ? 6 : 5,
                          child: const TopViewsWrapper(
                              child: MainTopContentView()),
                        ),
                        //SELECT PAYMENT METHOD AND THE FLIGHT DETAILS
                        const TopViewsWrapper(child: FlightMoreInfo()),
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: const [
                              FlightAttendantsContentViewWrapper(
                                child: FlightAttendantsContentView(),
                              ),
                              CardSliderWrapper(child: CardsSlider()),
                            ],
                          ),
                        )
                      ],
                    ),
                    AnimatedPositioned(
                        top: ref.watch(viewProvider) == 0
                            ? (MediaQuery.of(context).size.height * 0.2)
                            : (MediaQuery.of(context).size.height * 0.185),
                        left: 15,
                        right: 15,
                        duration: const Duration(milliseconds: 600),
                        child: Hero(
                          tag: '__Flight__',
                          child: Image.asset(
                            Assets.assetsAirplane,
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: const ButtonNavigationView(),
        ));
  }
}
