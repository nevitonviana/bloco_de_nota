import '../../../core/notifier/default_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_services.dart';

class LoginController extends DefaultChangeNotifier {
  final UserServices _userServices;
  String? infoMessage;

  LoginController({required UserServices userService})
      : _userServices = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final _user = await _userServices.googleLogin();

      if (_user != null) {
        success();
      } else {
        _userServices.logout();
        setError("error ao realizar login com o google");
      }
    } on AuthException catch (e) {
      _userServices.logout();
      setError(e.massage);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
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

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userServices.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para sua E-mail';
    } catch (e) {
      if (e is AuthException) {
        setError(e.massage);
      }
      setError("errora ao reset senha");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
