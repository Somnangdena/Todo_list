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
    await DbHelper.updateUser(task);
    getTask();
  }

  void delete(Task task) async {
    await DbHelper.delete(task);
    getTask();
  }
  // void getTask() async {
  //   List<Map<String, dynamic>> tasks = await DbHelper.query();
  //   taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  // }
}
