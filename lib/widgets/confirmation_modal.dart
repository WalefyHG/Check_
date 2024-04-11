import 'package:check/presentations/models/todolist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../presentations/controllers/todocontroller.dart';



class ConfirmationModal extends StatelessWidget{
  final TodoModel todo;

  const ConfirmationModal({super.key, required this.todo});

  @override
  Widget build(BuildContext context){
    final todoCtrl = Provider.of<TodoController>(context);
    return Consumer<TodoController>(
      builder: (context, todoCtrl, child){
        return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            backgroundColor: roxoBase,
            content: SizedBox(
                width: 300,
                height: 200,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Deseja realmente concluir esta tarefa?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Cancelar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                todoCtrl.toggleTodoAtIndex(todo.id);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Concluir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            )
        );
      }
    );
  }
}