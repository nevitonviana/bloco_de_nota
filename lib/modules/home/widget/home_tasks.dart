import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '/models/task_filter_enum.dart';
import '../home_controller.dart';
import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Selector<HomeController, String>(
          selector: (context, controller) =>
              controller.filterSelected.description,
          builder: (context, value, child) => Text("TASK\'S DE $value"),
        ),
        Column(
          children: context
              .select<HomeController, List<TaskModel>>(
                  (value) => value.filteredTasks)
              .map((e) => Task(
                    model: e,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
