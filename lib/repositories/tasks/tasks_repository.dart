import '../../models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);

  Future<List<TaskModel>> findByPeriod(DateTime star, DateTime end);

  Future<void> checkOrUncheckTask(TaskModel task);
}
