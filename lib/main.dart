import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DbHelper.initDB();
  runApp(const MyApp());
}
