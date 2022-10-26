import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
import 'tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime star, DateTime end) async {
    final starFilter = DateTime(star.year, star.month, star.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
    select * from todo
    where data_hora between ? and ?
    order by data_hora
    ''', [starFilter.toIso8601String(), endFilter.toIso8601String()]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final finished = task.finished ? 1 : 0;
    await conn.rawQuery(
        'update todo set finalizado = ? where id = ?', [finished, task.id]);
  }
}
