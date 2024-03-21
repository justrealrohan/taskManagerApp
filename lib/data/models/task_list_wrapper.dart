import 'task_item.dart';


class TaskListWrapper {
  String? status;
  List<TaskItem>? taskList;

  TaskListWrapper({this.status, this.taskList});

  TaskListWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    taskList = <TaskItem>[];
    json['data'].forEach((v) {
      taskList!.add(TaskItem.fromJson(v));
    });
  }
}



