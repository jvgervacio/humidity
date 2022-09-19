import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:humidity/services/firebase-auth-helper.dart';

import '../../enums/auth-result-status.dart';

class SignUpViewModel extends BaseViewModel {
  bool _isloading = false;
  bool get isLoading => _isloading;

  final TextEditingController _email = TextEditingController();
  TextEditingController get emailController => _email;
  final TextEditingController _password = TextEditingController();
  TextEditingController get passwordController => _password;
  final TextEditingController _confirmPassword = TextEditingController();
  TextEditingController get confirmPassword => _confirmPassword;

  bool emailError = false;
  bool passError = false;
  bool confirmpassError = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResultStatus> signUp(BuildContext context) async {
    final status = await FirebaseAuthHelper().createAccount(email: _email.value.text, pass: _password.value.text);
    return status;
  }

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }
}
