import 'package:check/presentations/models/todolist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../presentations/controllers/todocontroller.dart';



class DeletingModal extends StatelessWidget{
  final TodoModel todo;

  const DeletingModal({super.key, required this.todo});

  @override
  Widget build(BuildContext context){
    final todoCtrl = Provider.of<TodoController>(context);
    return Consumer<TodoController>(
      builder: (context, todoCtrl, child){
        return AlertDialog(
            backgroundColor: roxoBase,
            contentPadding: const EdgeInsets.all(10),
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
                        const Text('Deseja realmente excluir esta tarefa?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
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
                                todoCtrl.removeTodoAtIndex(todo.id);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Excluir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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