import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';
import '/core/ui/theme_extensions.dart';
import 'todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filtros",
          style: context.titleStyle,
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'Hoje',
                taskFilter: TaskFilterEnum.today,
                totalTaskModel:
                    TotalTaskModel(totalTasksFinish: 10, totalTask: 5),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                  label: 'Hoje',
                  taskFilter: TaskFilterEnum.tomorrow,
                  totalTaskModel:
                      TotalTaskModel(totalTasksFinish: 5, totalTask: 5),
                  selected: context.select<HomeController, TaskFilterEnum>(
                          (value) => value.filterSelected) ==
                      TaskFilterEnum.tomorrow),
              TodoCardFilter(
                  label: 'Hoje',
                  taskFilter: TaskFilterEnum.week,
                  totalTaskModel:
                      TotalTaskModel(totalTasksFinish: 15, totalTask: 5),
                  selected: context.select<HomeController, TaskFilterEnum>(
                          (value) => value.filterSelected) ==
                      TaskFilterEnum.week),
            ],
          ),
        )
      ],
    );
  }
}
