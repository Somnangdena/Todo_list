import 'package:get/get.dart';
import 'package:todo_list/db/db_helper.dart';
import 'package:todo_list/models/task.dart';

class TaskController extends GetxController {
  

  @override
  void onReady() {
    //getTask();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  // void getTask() async {
  //   List<Map<String, dynamic>> tasks = await DbHelper.query();
  //   taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  // }
}
