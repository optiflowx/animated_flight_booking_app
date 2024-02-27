// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../components/user_tile.dart';
import '../../data/users.dart';

class FlightAttendantsView extends StatelessWidget {
  const FlightAttendantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black26, spreadRadius: 5, blurRadius: 20)
          ]),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(Users.data.length, (index) {
              return UserTile(
                name: Users.data[index].userName,
                email: Users.data[index].userEmail,
                image: Users.data[index].image,
              );
            }),
          ),
          PaymentDetailsView(context),
        ],
      ),
    );
  }

  Widget PaymentDetailsView(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Total you will pay',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '\$ 1,536.00',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Split payment',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 5),
                Icon(Icons.check_circle_sharp, color: Colors.blue, size: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
