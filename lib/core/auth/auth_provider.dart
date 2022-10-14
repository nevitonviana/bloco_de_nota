import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/user/user_services.dart';
import '../navigator/todo_list_navigator.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserServices _userServices;

  AuthProvider(
      {required FirebaseAuth firebaseAuth, required UserServices userService})
      : _firebaseAuth = firebaseAuth,
        _userServices = userService;

  Future<void> logout() => _userServices.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.idTokenChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil("/login", (route) => false);
      }
    });
  }
}
