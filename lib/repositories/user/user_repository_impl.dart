import 'package:firebase_auth/firebase_auth.dart';

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
}
