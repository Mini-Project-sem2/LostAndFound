import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

double _findPercentage(Color color1, Color color2) {
  int r1 = color1.red;
  int g1 = color1.green;
  int b1 = color1.blue;

  int r2 = color2.red;
  int g2 = color2.green;
  int b2 = color2.blue;

  double percentage =
      ((r1 - r2).abs() + (g1 - g2).abs() + (b1 - b2).abs()) / 765.0;

  return percentage;
}

bool compareColour(int color1, int color2) {
  Color colorOne = Color(color1);
  Color colorTwo = Color(color2);
  double percentage = _findPercentage(colorOne, colorTwo);
  return percentage < 35.0;
}
