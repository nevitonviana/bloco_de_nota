import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (context) => HomeController(),
          ),
        ], routes: {
          '/home': (context) => const HomePage(),
        });
}
