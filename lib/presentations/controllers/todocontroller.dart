import 'dart:convert';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:check/widgets/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/todolist.dart';

class TodoController extends ChangeNotifier{
  late List<TodoModel> todos;
  final SharedPreferences _prefs;
  final String _key = 'todo_list';
  final Uuid _uuid = const Uuid();

  TodoController(this._prefs){
    todos = [];
    loadListFromLocalStorage();
  }

  String getTodosStatusString(){
    final notCompleted = todos.where((element) => !element.isDone);
    if(todos.isEmpty){
      return 'Nenhuma atividade cadastrada';
    }else if(notCompleted.isEmpty) {
      return 'Todas as atividades foram concluídas';
    }
    return "Você possui ${notCompleted.length} tarefa${notCompleted.length == 1 ? '' : 's'}";
  }


  void addTodo(TodoModel todo){
    final String id = _uuid.v4();
    final newTodo = TodoModel(todo.title, descriptionC: todo.description, dateC: todo.date, idC: id, isDoneC: false);
    todos.add(newTodo);
    saveListToLocalStorage();
    notifyListeners();
  }

  void removeTodoAtIndex(String id){
    final index = todos.indexWhere((todo) => todo.id == id);
    if(index != -1){
      todos.removeAt(index);
      saveListToLocalStorage();
    }
    notifyListeners();
    print(todos.length);
  }

  void toggleTodoAtIndex(String id){
    final index = todos.indexWhere((todo) => todo.id == id);
    if(index != -1){
      todos[index].isDone = !todos[index].isDone;
      saveListToLocalStorage();
    }
    notifyListeners();
  }

  void clearLocalStorage(){
    _prefs.clear();
    todos.clear();
    notifyListeners();
  }

  Future<void> saveListToLocalStorage() async{
    final String todoListJson = jsonEncode(todos);
    await _prefs.setString(_key, todoListJson);
  }

  void loadListFromLocalStorage() async{
    final String? todoListJson = _prefs.getString(_key);
    if(todoListJson != null){
      final List<dynamic> todoList = jsonDecode(todoListJson);
      todos = todoList.map((e) => TodoModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  void setAlarm(TimeOfDay selectedTime, TodoModel todo) async{
    final now = DateTime.now();
    final int alarmId = todo.id.hashCode;
    final scheduleDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    todo.hasAlarm = true;
    saveListToLocalStorage();
    notifyListeners();
    print('alarme setado');

    if(todo.hasAlarm){
      try{
        await AndroidAlarmManager.oneShotAt(
          scheduleDateTime,
          alarmId,
          callback,
          exact: true,
          wakeup: true,
        );
        print('Foi alarmado para $scheduleDateTime');
      }catch(e){
        print('Erro no alarme shot: $e');
      }
    }
  }

  void cancelAlarm(TodoModel todo) async{
    final int alarmId = todo.id.hashCode;
    await AndroidAlarmManager.cancel(alarmId);
    todo.hasAlarm = false;
    saveListToLocalStorage();
    notifyListeners();
  }


  static void callback(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final todos = TodoController(prefs).todos;

    final todo = todos.firstWhere((element) => element.id.hashCode == id);

    print('todo.hasAlarm: ${todo.hasAlarm}');

    if(todo.hasAlarm) {
      todo.hasAlarm = false;
      await TodoController(prefs).saveListToLocalStorage();
      await TodoController(prefs).notifyListeners();
      print('Callback chamado para ${todo.title} e hasAlarm: ${todo.hasAlarm}');

      try {
        await NotificationHelper.scheduledNotification(
          id,
          todo.title,
          todo.description ?? '',
        );
        print('Notificação enviada para ${todo.title}');
      } catch (e) {
        print('Erro no callback: $e');
      }
    }
    }


  @override
  Future<void> notifyListeners() async {
    super.notifyListeners();
  }
}


