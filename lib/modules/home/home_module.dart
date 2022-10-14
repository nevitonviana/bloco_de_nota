import '../../core/modules/todo_list_module.dart';
import 'home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(routes: {
          '/home': (context) => const HomePage(),
        });
}
