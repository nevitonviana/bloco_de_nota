import 'package:flutter/material.dart';

import '/core/ui/theme_extensions.dart';
import 'widget/home_drawer.dart';
import 'widget/home_header.dart';
import 'widget/todo_card_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt_rounded),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                  child: Text("Mostrar tarefas concluidas")),
            ],
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        HomeHeader(),
                        TodoCardFilter(),

                      ],),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
