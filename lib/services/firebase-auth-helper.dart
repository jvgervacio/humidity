import 'package:google_sign_in/google_sign_in.dart';
import 'package:humidity/enums/auth-result-status.dart';
import 'package:humidity/globals.dart';
import 'package:humidity/services/auth-exception-handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  ///
  /// Helper Functions
  ///

  Future<AuthResultStatus> createAccount({email, pass}) async {
    if (email.toString().isEmpty && pass.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    } else if (email.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    } else if (pass.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    }
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    if (email.toString().isEmpty && pass.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    } else if (email.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    } else if (pass.toString().isEmpty) {
      return AuthResultStatus.emptyEmailPass;
    }
    try {
      final authResult = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      currentUser = authResult;
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print("asd");
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }

  Future<AuthResultStatus> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    try {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      // Getting users credential
      final authResult = await _auth.signInWithCredential(authCredential);
      currentUser = authResult;
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  void logoOut() {
    _auth.signOut();
  }
}
