import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user/user_repository.dart';
import 'user_services.dart';

class UserServicesImpl implements UserServices {
  final UserRepository _userRepository;

  UserServicesImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);
}
