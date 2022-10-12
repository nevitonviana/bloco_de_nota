import 'package:flutter/material.dart';

import '../../../exception/auth_exception.dart';
import '../../../services/user/user_services.dart';

class RegisterController extends ChangeNotifier {
  final UserServices _userServices;
  String? error;
  bool success = false;

  RegisterController({required UserServices userServices}) : _userServices = userServices;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();

      final user = await _userServices.register(email, password);
      if (user != null) {
        success = true;
      } else {
        error = "erro ao registar usuario";
      }
    } on AuthException catch (e) {
      error = e.massage;
    } finally {
      notifyListeners();
    }
  }
}
