import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productivity_hub/models/To-do/Tasks_model.dart';





class TodoListNotifier extends StateNotifier<List<Task>> {
  TodoListNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(String title) {
    state = state.where((task) => task.title != title).toList();
  }

  void toggleTaskCompletion(String title) {
    state = state.map((task) {
      if (task.title == title) {
        return Task(
             endDate: task.endDate,
          id: task.id,
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          priority: task.priority,
          isCompleted: !task.isCompleted,
          task_type: task.task_type
        );
      }
      return task;
    }).toList();
  }

  void updateTask(Task updatedTask) {
    state = state.map((task) {
      if (task.title == updatedTask.title) {
        return updatedTask;
      }
      return task;
    }).toList();
  }
   List<Task> get completedTasks {
    return state.where((task) => task.isCompleted).toList();
  }
  }


final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Task>>((ref) {
  return TodoListNotifier();
});
