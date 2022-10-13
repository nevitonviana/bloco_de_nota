import '../../../core/notifier/default_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_services.dart';

class LoginController extends DefaultChangeNotifier {
  final UserServices _userServices;

  LoginController({required UserServices userService})
      : _userServices = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userServices.login(email, password);
      if (user != null) {
        success();
      } else {
        setError("usuario ou senha invalidos");
      }
    } on AuthException catch (e) {
      setError(e.massage);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void forgotPassword(String email){
    showLoadingAndResetState();

  }


}
