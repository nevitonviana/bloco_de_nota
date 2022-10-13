import '../../../core/notifier/default_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_services.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserServices _userServices;

  RegisterController({required UserServices userServices})
      : _userServices = userServices;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userServices.register(email, password);
      if (user != null) {
        success();
      } else {
        setError("erro ao registar usuario");
      }
    } on AuthException catch (e) {
      setError(e.massage);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
