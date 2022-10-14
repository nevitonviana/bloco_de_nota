import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../exception/auth_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      if (e.email == "email-already-in-use") {
        final _LoginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (_LoginTypes.contains("password")) {
          throw AuthException(massage: "E-mail já ultilizado");
        } else {
          throw AuthException(massage: "Voçê já e cadestrodo pelo google");
        }
      } else {
        throw AuthException(massage: e.message ?? "Error ao registrar usuario");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      throw AuthException(massage: e.message ?? "error ao realiza o login");
    } on FirebaseAuthException catch (e, s) {
      if (e.code == "wrong-password") {
        throw AuthException(massage: "Email ou senha invalidos");
      }

      throw AuthException(massage: e.message ?? "error ao realiza o login");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains("password")) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains("google")) {
        throw AuthException(
            massage:
                "cadastro nao realizado com E-mail e senha, e sim com  google");
      } else {
        throw AuthException(massage: "E-Mail nao encontrado");
      }
    } on PlatformException catch (e) {
      throw AuthException(massage: "error ao resetar senha");
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSingIn = GoogleSignIn();
      final googleUser = await googleSingIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains("password")) {
          throw AuthException(massage: "E-mail ja ultilizado");
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      if (e.code == "account-exists-with-different-credential ") {
        throw AuthException(massage: '''
        login invalido se resgistrou com os seguntis provides:
        ${loginMethods?.join(',')}
        ''');
      } else {
        throw AuthException(massage: "error ao realiza login");
      }
    }

  }
}
