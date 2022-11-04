import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  @observable
  Task? activeTask;

  @observable
  ObservableList<Task> userTasks = ObservableList();

  @observable
  String? taskError;

  TaskStoreBase() {
    activeTask = null;
    userTasks = ObservableList();
    taskError = "";
  }

  @action
  setTasks(List<Task> tasks) {
    userTasks.clear();

    userTasks.addAll(tasks);
  }

  @action
  addTask(Task task) {
    userTasks.add(task);
  }

  @action
  setActiveTask(Task task) {
    activeTask = task;
  }

  @action
  clearActiveTask() {
    activeTask = null;
  }

  @action
  setTaskError(String error) {
    taskError = error;
  }

  @action
  clearTaskError() {
    taskError = null;
  }
}
