import '../../core/notifier/default_notifier.dart';
import '../../models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  var filterSelected = TaskFilterEnum.today;
}
