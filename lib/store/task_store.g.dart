// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on TaskStoreBase, Store {
  late final _$userTasksAtom =
      Atom(name: 'TaskStoreBase.userTasks', context: context);

  @override
  ObservableList<Task> get userTasks {
    _$userTasksAtom.reportRead();
    return super.userTasks;
  }

  @override
  set userTasks(ObservableList<Task> value) {
    _$userTasksAtom.reportWrite(value, super.userTasks, () {
      super.userTasks = value;
    });
  }

  late final _$TaskStoreBaseActionController =
      ActionController(name: 'TaskStoreBase', context: context);

  @override
  dynamic setTasks(List<Task> tasks) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setTasks');
    try {
      return super.setTasks(tasks);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addTask(Task task) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.addTask');
    try {
      return super.addTask(task);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userTasks: ${userTasks}
    ''';
  }
}
