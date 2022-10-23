import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';
import '/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCardFilter(
      {Key? key,
      required this.label,
      required this.taskFilter,
      this.totalTaskModel,
      required this.selected})
      : super(key: key);

  double _getPercentFinish() {
    final total = totalTaskModel?.totalTask ?? 0.0;
    final totalFinish = totalTaskModel?.totalTasksFinish ?? 0.1;
    if (total == 0) return 0.0;

    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 150,
          maxHeight: 120,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.green.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${totalTaskModel?.totalTask ?? 0} TASKS",
              style: context.titleStyle.copyWith(
                  fontSize: 10, color: selected ? Colors.white : Colors.green),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0.0,
                end: _getPercentFinish(),
              ),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      selected ? Colors.white : context.primaryColor),
                  value: value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
