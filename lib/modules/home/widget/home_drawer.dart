import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/messages.dart';
import '/core/ui/theme_extensions.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) =>
                      authProvider.user?.photoURL ??
                      "https://tm.ibxk.com.br/2017/06/22/22100428046161.jpg?ims=900x900",
                  builder: (_, value, __) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Selector<AuthProvider, String>(
                      selector: (context, authProvider) =>
                          authProvider.user?.displayName ??
                          "Nome nao informado",
                      builder: (_, value, __) => Text(value),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: const Text("Alterar Name"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Alterar Name"),
                  content: TextField(
                    onChanged: (value) => nameVN.value = value,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (nameVN.value.isEmpty) {
                            Messages.of(context).showError("Name OBrigatorio");
                          }
                        },
                        child: const Text("Salvar")),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Sair"),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}
