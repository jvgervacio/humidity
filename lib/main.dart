import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:humidity/gen/fonts.gen.dart';
import 'package:humidity/route/route.dart' as route;

import 'gen/assets.gen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "HUMIDITY APP",
    debugShowCheckedModeBanner: false,
    onGenerateRoute: route.onGenerateRoute,
    initialRoute: route.splash,
    theme: ThemeData(fontFamily: FontFamily.lato),
  ));
}
