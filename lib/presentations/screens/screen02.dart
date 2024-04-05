import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../controllers/todocontroller.dart';

final todoCtrl = TodoController();

class Screen02 extends StatelessWidget {
  const Screen02({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoCtrl.todos.length,
      itemBuilder: (_, int index) {
        final todo = todoCtrl.todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (_) {
              todoCtrl.onChangeCompletedTodo(todo);
            },
          ),
          title: Text(
            todo.title,
            style: const TextStyle(
              color: roxoEscuro,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoCtrl.onRemoveTodo(todo);
            },
          ),
          subtitle: Text(
            todo.description ?? '',
            style: const TextStyle(
              color: roxoEscuro,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}