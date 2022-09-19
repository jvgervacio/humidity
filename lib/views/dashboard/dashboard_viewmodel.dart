import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class DashboardViewModel extends BaseViewModel {
  late FirebaseDatabase _dbInstance;
  dynamic _humidity = 0;
  dynamic _temperature = 0;
  DateFormat dateformat = DateFormat('EEE MMM dd kk:mm:ss yyyy');
  String get humidity => _humidity.toString();
  String get temperature => _temperature.toString();
  FirebaseDatabase get firebaseInstance => _dbInstance;

  DashboardViewModel() {
    _dbInstance = FirebaseDatabase.instance;
    _dbInstance.ref("sensor_log").onValue.listen((event) {
      final data = event.snapshot;
      _temperature = data.child("temperature").value;
      _humidity = data.child("humidity").value;
      notifyListeners();
    });
  }

  void printResult() {}

  String formatDate(DateTime time) {
    return dateformat.format(time);
  }

  DateTime parseDate(String formattedString) {
    return dateformat.parse(formattedString);
  }

  void printLatest() {
    _dbInstance.ref("logs").orderByKey().startAfter(1);
  }
}
