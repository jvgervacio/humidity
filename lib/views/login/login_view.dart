import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humidity/enums/auth-result-status.dart';
import 'package:humidity/gen/assets.gen.dart';
import 'package:humidity/gen/fonts.gen.dart';
import 'package:humidity/globals.dart';
import 'package:humidity/route/route.dart' as route;
import 'package:humidity/services/auth-exception-handler.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:humidity/widget/textfield_widget.dart';

import 'login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late RiveAnimationController _controller;
  late RiveAnimation humiAnimation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    _controller = SimpleAnimation('hello', autoplay: true);
    humiAnimation = RiveAnimation.asset(Assets.rive.humi, controllers: [_controller], fit: BoxFit.contain);
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => ScreenUtilInit(
        designSize: const Size(1080, 2280),
        builder: () => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ThemeColor.bgColor,
          body: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(50.w),
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 500.h,
                              child: humiAnimation,
                            ),
                            Align(
                              child: Text("WELCOME TO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FontFamily.oswald,
                                    fontSize: 70.sp,
                                    color: ThemeColor.primaryTextColor,
                                  )),
                            ),
                            Text("HUMIDITY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.alatsi,
                                  fontSize: 130.sp,
                                  height: 1,
                                  color: ThemeColor.primary,
                                )),
                            SizedBox(
                              height: 150.h,
                            ),
                            TextFieldWidget(
                              label: "Email",
                              controller: model.emailController,
                              iconData: Icons.email_outlined,
                              error: model.emailError,
                              onChanged: (text) => model.setEmailError(false),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            PasswordTextFieldWidget(
                              label: "Password",
                              controller: model.passwordController,
                              iconData: Icons.lock_outline_rounded,
                              error: model.passError,
                              onChanged: (text) => model.setPassError(false),
                            ),
                            SizedBox(
                              height: 150.h,
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 150.h,
                                child: MaterialButton(
                                  onPressed: () => model.signIn(context).then((status) {
                                    model.setErrors(status);
                                    if (status == AuthResultStatus.successful) {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Container(
                                          padding: EdgeInsets.all(50.r),
                                          child: const Text("Logged in Successfully"),
                                        ),
                                        backgroundColor: Colors.green,
                                      ));

                                      Future.delayed(const Duration(seconds: 1), () {
                                        Navigator.pushNamed(context, route.dashboard);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        content: Container(
                                          padding: EdgeInsets.all(50.r),
                                          child: Text(AuthExceptionHandler.generateExceptionMessage(status)),
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  }),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                  color: ThemeColor.primary,
                                  textColor: Colors.white,
                                  child: model.signIsLoading
                                      ? SizedBox(
                                          height: 60.h,
                                          width: 60.w,
                                          child: const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text("SIGN IN"),
                                )),
                            SizedBox(
                              height: 50.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.white38,
                                    thickness: 2.h,
                                    endIndent: 20.w,
                                  ),
                                ),
                                Text(
                                  "OR",
                                  style: TextStyle(color: Colors.white38, fontSize: 30.sp),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white38,
                                    thickness: 2.h,
                                    indent: 20.w,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 150.h,
                              child: MaterialButton(
                                onPressed: () => model.signInWithGoogle(context).then((status) {
                                  if (status == AuthResultStatus.successful) {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      content: Container(
                                        padding: EdgeInsets.all(50.r),
                                        child: const Text("Logged in Successfully"),
                                      ),
                                      backgroundColor: Colors.green,
                                    ));

                                    Future.delayed(const Duration(seconds: 1), () {
                                      Navigator.pushNamed(context, route.dashboard);
                                    });
                                  } else {
                                    model.setErrors(status);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AuthExceptionHandler.generateExceptionMessage(status),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                child: model.googleSignIsLoading
                                    ? SizedBox(
                                        height: 60.h,
                                        width: 60.w,
                                        child: CircularProgressIndicator(
                                          color: ThemeColor.primary,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Assets.images.googleLogo.image(height: 80.h),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          const Text("Sign in with Google")
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, route.signupPage),
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: ThemeColor.primary,
                                      fontSize: 40.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
