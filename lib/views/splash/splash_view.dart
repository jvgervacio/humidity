import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humidity/gen/assets.gen.dart';
import 'package:humidity/gen/fonts.gen.dart';
import 'package:humidity/globals.dart' as global;
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:rive/rive.dart' as rive;
import 'package:humidity/route/route.dart' as route;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../globals.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    _controller = SimpleAnimation('running', autoplay: true);
    _controller.isActive = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: ThemeColor.bgColor));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Future.delayed(const Duration(seconds: 5), () => {Navigator.popAndPushNamed(context, route.loginPage)});

    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: global.ThemeColor.bgColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 700.h,
                    child: RiveAnimation.asset(Assets.rive.humi, controllers: [_controller], fit: BoxFit.contain),
                  ),
                  Text("HUMIDITY",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontFamily.alatsi,
                        fontSize: 120.sp,
                        color: global.ThemeColor.primary,
                      )),

                  // LoadingAnimationWidget.inkDrop(
                  //   color: global.ThemeColor.primary,
                  //   size: 100.sp,
                  // )
                  Lottie.asset(Assets.lottie.loadingWave),
                ],
              ),
            ),
            Positioned.fill(
              bottom: 50.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    subtext("CREATED BY GROUP 1:", 30.sp),
                    subtext("GERVACIO", 30.sp),
                    subtext("BAGUIO", 30.sp),
                    subtext("MAGALSO", 30.sp),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Text subtext(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: FontFamily.lato,
      height: 6.h,
      fontSize: size,
      color: global.ThemeColor.subTextColor,
      letterSpacing: 10.w,
    ),
  );
}
