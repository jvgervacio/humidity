import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:humidity/enums/auth-result-status.dart';
import 'package:stacked/stacked.dart';
import 'package:humidity/route/route.dart' as route;
import 'package:humidity/services/firebase-auth-helper.dart';

class LoginViewModel extends BaseViewModel {
  bool _googleSignIsLoading = false;
  bool get googleSignIsLoading => _googleSignIsLoading;

  bool _signIsLoading = false;
  bool get signIsLoading => _signIsLoading;

  final TextEditingController _email = TextEditingController();
  TextEditingController get emailController => _email;
  final TextEditingController _password = TextEditingController();
  TextEditingController get passwordController => _password;

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool emailError = false;
  bool passError = false;

  Future<AuthResultStatus> signInWithGoogle(BuildContext context) async {
    setGoogleSignInLoading(true);
    final status = await FirebaseAuthHelper().loginWithGoogle();
    setGoogleSignInLoading(false);
    return status;
  }

  Future<AuthResultStatus> signIn(BuildContext context) async {
    final String email = _email.value.text;
    final String pass = _password.value.text;

    setSignInLoading(true);
    final status = await FirebaseAuthHelper().login(email: email, pass: pass);
    setSignInLoading(false);
    return status;
  }

  void setGoogleSignInLoading(bool isLoading) {
    _googleSignIsLoading = isLoading;
    notifyListeners();
  }

  void setSignInLoading(bool isLoading) {
    _signIsLoading = isLoading;
    notifyListeners();
  }

  void setEmailError(bool error) {
    emailError = error;
    notifyListeners();
  }

  void setPassError(bool error) {
    passError = error;
    notifyListeners();
  }

  void setErrors(AuthResultStatus exceptionCode) {
    emailError = passError = false;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        setEmailError(true);
        break;
      case AuthResultStatus.wrongPassword:
        setPassError(true);
        break;
      case AuthResultStatus.userNotFound:
        setEmailError(true);
        setPassError(true);
        break;
      default:
        setEmailError(true);
        setPassError(true);
    }
  }
}
