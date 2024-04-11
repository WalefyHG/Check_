import 'package:check/presentations/screens/todoDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../controllers/todocontroller.dart';
import 'home_screen.dart';


class Screen02 extends StatelessWidget {
  const Screen02({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCtrl = Provider.of<TodoController>(context);
    return Consumer<TodoController>(
      builder: (context, todoCtrl, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  todoCtrl.getTodosStatusString(),
                  style: const TextStyle(
                    color: roxoEscuro,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todoCtrl.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoCtrl.todos[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: todo.isDone ? [const Color(0xff5dd355), const Color(0xff074018)] : [roxoClaro2, roxo],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoDetailsScreen(todo: todo),
                          ),
                        );
                      },
                      leading: Checkbox(
                        value: todo.isDone,
                        checkColor: roxoBase,
                        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.white;
                          }
                          return Colors.white.withOpacity(0.4);
                        }),
                        onChanged: (value) {
                          if (value == true) {
                            showConfirmationModal(context, todo);
                          } else {
                            todoCtrl.toggleTodoAtIndex(todo.id);
                          }
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        todo.description ?? '',
                        style: TextStyle(
                          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (todo.hasAlarm) const Icon(Icons.alarm, color: Colors.white),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            iconColor: Colors.white,
                            elevation: 1,
                            onSelected: (String result) async {
                              if (result == 'delete') {
                                showDeleteModal(context, todo);
                              } else if (result == 'all') {
                                showModalClear(context, todo);
                              } else if (result == 'alarm') {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if(selectedTime != null){
                                  todoCtrl.setAlarm(selectedTime, todo);
                                }
                              }else if(result == 'cancel_alarm'){
                                todoCtrl.cancelAlarm(todo);
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text('Excluir', style: TextStyle(color: Colors.red)),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'all',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete_forever,
                                    color: roxoClaro,
                                  ),
                                  title: Text('Excluir todas', style: TextStyle(color: roxoClaro)),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'alarm',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.alarm,
                                    color: roxoBase,
                                  ),
                                  title: Text('Definir alarme', style: TextStyle(color: roxoBase)),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'cancel_alarm',
                                child: ListTile(
                                  leading: Icon(
                                    Icons.alarm_off,
                                    color: Colors.red,
                                  ),
                                  title: Text('Cancelar alarme', style: TextStyle(color: Colors.red)),
                                ),
                              )
                            ],
                          ),
                        ]
                      )
                    )
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}