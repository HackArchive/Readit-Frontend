import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  @observable
  ObservableList<Task> userTasks = ObservableList();

  TaskStoreBase() {
    userTasks = ObservableList();
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
}
