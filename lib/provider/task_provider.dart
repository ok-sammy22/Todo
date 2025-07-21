import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/task_model.dart';
import 'package:uuid/uuid.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
final uuid = Uuid();

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void updateTask(
    String id,
    String newTitle,
    String newContent,
    Category newCategory,
  ) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(
            title: newTitle,
            content: newContent,
            category: newCategory,
          )
        else
          task,
    ];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void completedtask(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(isCompleted: true) else task,
    ];
  }
}
