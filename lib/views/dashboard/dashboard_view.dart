// ignore_for_file: non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humidity/gen/assets.gen.dart';
import 'package:humidity/gen/fonts.gen.dart';
import 'package:humidity/globals.dart';
import 'package:humidity/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DashboardViewModel viewmodel;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    await FirebaseAuth.instance.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) => ScreenUtilInit(
        designSize: const Size(1080, 2280),
        builder: () => Scaffold(
          backgroundColor: ThemeColor.bgColor,
          body: Stack(
            children: [
              Align(alignment: Alignment.topCenter, child: Container(padding: EdgeInsets.only(top: 50.h), child: Lottie.asset(Assets.lottie.wavy))),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    height: 300.h,
                    width: double.infinity,
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "DASHBOARD",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: FontFamily.oswald,
                            fontSize: 120.h,
                            color: ThemeColor.secondaryTextColor,
                          ),
                        ),
                      ),
                    )),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(Assets.lottie.backgroundAura),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 200.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            dataViewContainer("HUMIDITY", model.humidity, Icons.water_drop_outlined, "%"),
                            SizedBox(
                              height: 100.h,
                            ),
                            dataViewContainer("TEMPERATURE", model.temperature, Icons.thermostat, "°C"),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomSheet: Container(
            height: 160.h,
            padding: EdgeInsets.all(30.r),
            color: ThemeColor.bgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Signed in as:   " + FirebaseAuth.instance.currentUser!.email!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container dataViewContainer(String label, String data, IconData icon, String unit) {
    Color primaryColor = ThemeColor.primaryTextColor;
    Color secondaryColor = ThemeColor.subTextColor;
    return Container(
      padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      //   color: Colors.blueAccent,
      //   boxShadow: const [
      //     BoxShadow(
      //       color: Colors.black26,
      //       offset: Offset(1, 2),
      //       blurRadius: 5,
      //       spreadRadius: 3,
      //     ),
      //   ],
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 400.h,
            width: 800.w,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      icon,
                      color: secondaryColor,
                      size: 150.sp,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      data,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: FontFamily.teko,
                        color: primaryColor,
                        fontSize: 500.h,
                        height: 1,
                        letterSpacing: 5.sp,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 20.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontFamily: FontFamily.oswald,
                        color: secondaryColor,
                        fontSize: 120.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: FontFamily.lato,
              color: secondaryColor,
              fontSize: 40.sp,
              height: 1.5,
              letterSpacing: 15.sp,
            ),
          )
        ],
      ),
    );
  }
}
