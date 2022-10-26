import 'package:flutter/material.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../tasks/tasks_module.dart';
import '/core/ui/theme_extensions.dart';
import 'home_controller.dart';
import 'widget/home_drawer.dart';
import 'widget/home_filters.dart';
import 'widget/home_header.dart';
import 'widget/home_tasks.dart';
import 'widget/home_week_filter.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;

  const HomePage({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _goToCreateTask(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
            TasksModule().getPage('/task/create', context),
      ),
    );
    widget._homeController.refreshPage();
  }

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._homeController).listener(
      context: context,
      successVoidCallback: (notifier, listenerNotifier) =>
          listenerNotifier.dispose(),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onSelected: (value) =>
                widget._homeController.showOrHideFinishingTasks(),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                  value: true,
                  child: Text(
                      "${widget._homeController.showFinishingTasks ? 'Esconder' : 'Mostrar'} tarefas concluidas")),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        backgroundColor: context.primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
