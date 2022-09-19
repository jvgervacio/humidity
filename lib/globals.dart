import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThemeColor {
  static Color get bgColor => const Color(0xFF272B38);
  static Color get primary => Colors.blue;
  static Color get primaryTextColor => Colors.white;
  static Color get secondaryTextColor => Colors.white;
  static Color get subTextColor => Color.fromARGB(155, 255, 255, 255);
}

late final UserCredential currentUser;
