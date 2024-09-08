import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:productivity_hub/models/To-do/Tasks_model.dart';
import 'package:productivity_hub/providers/to_do_provider.dart';

import 'package:productivity_hub/view/To-do_section/To-Do_page.dart'; // Import selectedDateProvider

class FilteredTasksNotifier extends StateNotifier<List<Task>> {
  FilteredTasksNotifier(this._ref) : super([]) {
    _updateFilteredTasks();

    // Listen to changes in the selected date and tasks
    _ref.listen<DateTime>(selectedDateProvider, (_, DateTime selectedDate) {
      _updateFilteredTasks();
    });

    _ref.listen<List<Task>>(todoListProvider, (_, __) {
      _updateFilteredTasks();
    });
  }

  final Ref _ref;

  void _updateFilteredTasks() {
    final selectedDate = DateTime.now() ;
    final tasks = _ref.read(todoListProvider);
    state = tasks.where((task) =>
        DateFormat('yyyy-MM-dd').format(task.dueDate) ==
        DateFormat('yyyy-MM-dd').format(selectedDate)).toList();
  }
}

final filteredTasksProvider = StateNotifierProvider<FilteredTasksNotifier, List<Task>>((ref) {
  return FilteredTasksNotifier(ref);
});
