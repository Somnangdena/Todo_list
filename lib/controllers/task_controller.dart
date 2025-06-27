import 'package:get/get.dart';
import 'package:todo_list/db/db_helper.dart';
import 'package:todo_list/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTask();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  void getTask() async {
    final task = await DbHelper.getTask();
    taskList.value = task;
  }

  // void updateUser(User user) async {
  //   await dbHelper.updateUser(user);
  //   fetchUsers();
  // }

  void markTaskCompleted(Task task) async {
    await DbHelper.updateTask(task);
    getTask();
  }

  Future<int> edit({required Task task}) async {
    if (task.id == null) {
      throw ArgumentError("Cannot edit task: ID is null");
    }
    return await DbHelper.editTask(task);
  }

  // Future<int> edit({Task? task}) async {
  //   return await DbHelper.editTask(task!);
  // }

  void delete(Task task) async {
    await DbHelper.delete(task);
    getTask();
  }
  // void getTask() async {
  //   List<Map<String, dynamic>> tasks = await DbHelper.query();
  //   taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  // }
}
