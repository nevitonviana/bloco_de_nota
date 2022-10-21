import 'package:todo_list/services/tasks/tasks_service.dart';

import '../../core/notifier/default_notifier.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError("data da task nao selecionada");
      }
    } catch (e) {
      setError("erro ao cadastrar task");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
