class Urls {
  static const String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$baseUrl/registration';
  static const String login = '$baseUrl/login';
  static const String createTask = '$baseUrl/createTask';
  static const String getAllTaskCountByStatus = '$baseUrl/taskStatusCount';
  static const String newTaskList = '$baseUrl/listTaskByStatus/New';
  static String deleteTask(String id) => '$baseUrl/deleteTask/$id';
  static String updateTaskById(String id, String status) => '$baseUrl/updateTaskStatus/$id/$status';
  static String completedTaskList = '$baseUrl/listTaskByStatus/Completed';
  static String cancelledTaskList  = '$baseUrl/listTaskByStatus/Cancelled';
  static String progressTaskList = '$baseUrl/listTaskByStatus/Progress';
}