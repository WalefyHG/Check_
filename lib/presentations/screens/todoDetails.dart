import 'package:check/presentations/models/todolist.dart';
import 'package:flutter/material.dart';

class TodoDetailsPopup extends StatelessWidget{
  final TodoModel todo;
  const TodoDetailsPopup({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(todo.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(todo.description ?? ''),
          const SizedBox(height: 10),
          Text('Data de entrega: ${todo.date}')
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}