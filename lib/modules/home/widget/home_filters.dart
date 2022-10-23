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
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.todayTotalTask),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                  label: 'AMANHÃ',
                  taskFilter: TaskFilterEnum.tomorrow,
                  totalTaskModel:
                      context.select<HomeController, TotalTaskModel?>(
                          (controller) => controller.tomorrowTotalTask),
                  selected: context.select<HomeController, TaskFilterEnum>(
                          (value) => value.filterSelected) ==
                      TaskFilterEnum.tomorrow),
              TodoCardFilter(
                  label: 'SEMANA',
                  taskFilter: TaskFilterEnum.week,
                  totalTaskModel:
                      context.select<HomeController, TotalTaskModel?>(
                          (controller) => controller.weekTotalTask),
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
