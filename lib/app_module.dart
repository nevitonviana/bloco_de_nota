import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/auth/auth_provider.dart';
import 'core/database/sqlite_migration_factory.dart';
import 'repositories/user/user_repository.dart';
import 'repositories/user/user_repository_impl.dart';
import 'services/user/user_services.dart';
import 'services/user/user_services_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuth.instance,
        ),
        Provider(
          create: (_) => SqliteMigrationFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<UserServices>(
          create: (context) => UserServicesImpl(userRepository: context.read()),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
              firebaseAuth: context.read(), userService: context.read())
            ..loadListener(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
