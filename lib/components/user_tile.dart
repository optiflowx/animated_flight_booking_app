// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name, email, image;

  const UserTile({
    Key? key,
    required this.name,
    required this.email,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SeeDetailsComponent()
        ],
      ),
    );
  }

  Widget SeeDetailsComponent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'See Details',
            style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        )
      ],
    );
  }
}
