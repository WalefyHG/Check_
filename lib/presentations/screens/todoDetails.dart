import 'package:check/constants/colors.dart';
import 'package:check/presentations/models/todolist.dart';
import 'package:flutter/material.dart';

class TodoDetailsPopup extends StatelessWidget{
  final TodoModel todo;
  const TodoDetailsPopup({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: roxoBase,
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        'Detalhes da atividade: ${todo.title}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
          width: 500,
          height: 200,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRow('Título:', todo.title),
                    const SizedBox(height: 20),
                    _buildRow(
                      'Status:',
                      todo.isDone ? ' Concluída ' : ' Pendente ',
                      color: todo.isDone ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 20),
                    _buildRow('Descrição:', todo.description ?? 'Sem descrição'),
                    const SizedBox(height: 20),
                    _buildRow('Data:', todo.date ?? 'Sem data'),
                  ],
                ),
              )
            ),
          )
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Fechar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}


Widget _buildRow(String label, String text, {Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '$label ',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: Wrap(
          children: [
            Text(
              text,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
