import 'package:signals/signals.dart';

import '../models/todolist.dart';

class TodoController {
  final todos = <TodoModel>[].toSignal();

  late final Computed<String> todosStatusString = computed(() {
    final notCompletedTodos = todos.where((todo) => !todo.isDone);

    if (todos.isEmpty){
      return "Você não possui nenhuma tarefa";
    }else if (notCompletedTodos.isEmpty){
      return "Todas as tarefas completadas";
    }
    return "Você possui ${notCompletedTodos.length} tarefa${notCompletedTodos.length == 1 ?'':'s'}";
  });


  void addTodo(TodoModel todo){
    todos.add(todo);
  }

  void onRemoveTodo(TodoModel todo){
    todos.removeWhere((todoFromList) => todoFromList.id == todo.id);
  }

  void onChangeCompletedTodo(TodoModel todoToUpdate){
    todos.value = todos.map((todo) {
      if(todo.id == todoToUpdate.id){
        return todo.copyWith(isDone: !todoToUpdate.isDone);
      }else{
        return todo;
      }
    }).toList();
    print(todos.value);
  }
}