import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humidity/gen/assets.gen.dart';
import 'package:humidity/gen/fonts.gen.dart';
import 'package:humidity/globals.dart';
import 'package:humidity/services/auth-exception-handler.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:humidity/widget/textfield_widget.dart';
import '../../enums/auth-result-status.dart';
import 'signup_viewmodel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late RiveAnimationController _controller;
  late RiveAnimation humiAnimation;
  String errorText = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late AuthResultStatus _status = AuthResultStatus.successful;
    _controller = SimpleAnimation('hello', autoplay: true);
    humiAnimation = RiveAnimation.asset(Assets.rive.humi, controllers: [_controller], fit: BoxFit.contain);
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => ScreenUtilInit(
        designSize: const Size(1080, 2280),
        builder: () => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ThemeColor.bgColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(100.w, 80.h, 100.w, 80.h),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("CREATE A NEW ACCOUNT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.oswald,
                                  fontSize: 80.sp,
                                  color: ThemeColor.primaryTextColor,
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Create an account to use our app.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.lato,
                                  color: ThemeColor.primaryTextColor,
                                )),
                          ),
                          SizedBox(height: 100.h),
                          TextFieldWidget(
                            label: "Email",
                            controller: model.emailController,
                            iconData: Icons.email_outlined,
                            error: model.emailError,
                            onChanged: (text) => {},
                            //error: true,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFieldWidget(
                            label: "Password",
                            controller: model.passwordController,
                            iconData: Icons.lock_outline_rounded,
                            error: model.emailError,
                            hide: true,
                            onChanged: (text) => {},
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextFieldWidget(
                            label: "Confirm Password",
                            controller: model.confirmPassword,
                            iconData: Icons.lock_open,
                            error: model.emailError,
                            hide: true,
                            onChanged: (text) => {},
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 150.h,
                              child: MaterialButton(
                                onPressed: () {
                                  model.setLoading(true);
                                  errorText = "";
                                  model.emailError = false;
                                  model.passError = false;
                                  model.confirmpassError = false;
                                  final email = model.emailController.text;
                                  final pass = model.passwordController.text;
                                  final confirm = model.confirmPassword.text;
                                  print("$email, $pass, $confirm ");
                                  setState(() {
                                    if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
                                      model.emailError = email.isEmpty;
                                      model.passError = pass.isEmpty;
                                      model.confirmpassError = confirm.isEmpty;
                                      if (email.isEmpty && pass.isEmpty && confirm.isEmpty) {
                                        errorText = "Please fill up the form first!";
                                      } else if (email.isEmpty) {
                                        errorText = "Email field cannot be empty!";
                                      } else if (pass.isEmpty) {
                                        errorText = "Password field cannot be empty!";
                                      } else {
                                        errorText = "Please confirm your password first!";
                                      }
                                      _status = AuthResultStatus.undefined;
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        content: Container(
                                          padding: EdgeInsets.all(50.r),
                                          child: Text(errorText),
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    } else if (confirm.compareTo(pass) != 0) {
                                      model.passError = true;
                                      model.confirmpassError = true;
                                      errorText = "Password did not match";
                                      _status = AuthResultStatus.undefined;

                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        content: Container(
                                          padding: EdgeInsets.all(50.r),
                                          child: Text(errorText),
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    } else {
                                      model.signUp(context).then(
                                        (status) async {
                                          setState(() {
                                            _status = status;
                                            errorText = "";
                                            switch (status) {
                                              case AuthResultStatus.successful:
                                                model.passwordController.text = "";
                                                model.emailController.text = "";
                                                model.confirmPassword.text = "";
                                                errorText = "Your account has been created successfully.";
                                                break;
                                              case AuthResultStatus.emailAlreadyExists:
                                                errorText = AuthExceptionHandler.generateExceptionMessage(status);
                                                model.emailError = true;
                                                break;
                                              case AuthResultStatus.invalidEmail:
                                                errorText = AuthExceptionHandler.generateExceptionMessage(status);
                                                model.emailError = true;
                                                break;
                                              case AuthResultStatus.weakPassword:
                                                errorText = AuthExceptionHandler.generateExceptionMessage(status);
                                                model.passError = true;
                                                break;
                                              default:
                                                errorText = AuthExceptionHandler.generateExceptionMessage(status);
                                            }
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                              content: Container(
                                                padding: EdgeInsets.all(50.r),
                                                child: Text(errorText),
                                              ),
                                              backgroundColor: status == AuthResultStatus.successful ? Colors.green : Colors.red,
                                            ));
                                          });
                                        },
                                      );
                                    }
                                  });
                                  model.setLoading(false);
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                color: ThemeColor.primary,
                                textColor: Colors.white,
                                child: model.isLoading
                                    ? SizedBox(
                                        height: 60.h,
                                        width: 60.w,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text("SIGN UP"),
                              )),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {Navigator.pop(context)},
                                child: Text(
                                  "Sign in",
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
