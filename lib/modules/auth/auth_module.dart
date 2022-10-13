import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
                create: (context) =>
                    LoginController(userService: context.read())),
            ChangeNotifierProvider<RegisterController>(
                create: (context) =>
                    RegisterController(userServices: context.read())),
          ],
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}
