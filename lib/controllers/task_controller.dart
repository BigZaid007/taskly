import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';


class TaskController extends GetxController {

   final RxList<Task>taskList=<Task>[].obs;

   Future<int> addTask({required Task task}){
     return DBHelper().insertNote(task);
   }

     getAllTaske() async
   {
    final tasks= await DBHelper().getAllNotes();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
   }

   deleteTasks(Task?task) async
   {
     await DBHelper().deleteNote(task!);
     getAllTaske();
   }

  updateTask(int id) async
{
  await DBHelper().updateNote(id);
  getAllTaske();
}

}
