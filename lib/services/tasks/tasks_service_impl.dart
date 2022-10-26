import 'package:todo_list/models/task_model.dart';

import '../../models/week_task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';
import 'tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var starFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (starFilter.weekday != DateTime.monday) {
      starFilter =
          starFilter.subtract(Duration(days: (starFilter.weekday - 1)));
    }

    endFilter = starFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(starFilter, endFilter);

    return WeekTaskModel(
        startDate: starFilter, endDate: endFilter, tasks: tasks);
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) =>
      _tasksRepository.checkOrUncheckTask(task);
}
