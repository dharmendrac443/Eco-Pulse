// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Appbar() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: 200, // Set a fixed height for the container
    child: Stack(
      children: [
        SvgPicture.asset(
          'assets/images/1.svg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: Text(
            'LeaderBoard',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
