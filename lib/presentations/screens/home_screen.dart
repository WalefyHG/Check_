import 'package:check/presentations/models/todolist.dart';
import 'package:check/presentations/screens/screen01.dart';
import 'package:check/presentations/screens/todoDetails.dart';
import 'package:flutter/material.dart';
import 'package:check/constants/colors.dart';
import 'package:signals/signals_flutter.dart';
import '../../widgets/add_form.dart';
import '../controllers/todocontroller.dart';
import 'about.dart';

final todoCtrl = TodoController();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Watch((context) {
        return todoCtrl.todos.isEmpty ? const Screen01() : const Screen02();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoModal(context);
        },
        elevation: 3,
        backgroundColor: roxoBase,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: roxo,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image(
                        image: AssetImage('assets/images/logos.png'),
                      ),
                    ),
                    Text(
                      'Bem-vindo!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                )
            ),
            ListTile(
              title: const Text('Tarefas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        _buildIconButton(),
      ],
    ),
  );
}
Widget _buildIconButton() {
  return InkWell(
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: roxoEscuro,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3),
        child:
        Icon(Icons.person_rounded, color: roxoEscuro, size: 25),
      ),
    ),
  );
}


class Screen02 extends StatelessWidget {
  const Screen02({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return Column(
        children: [
          Text(
            todoCtrl.todosStatusString.toString(),
            style: const TextStyle(
              color: roxoEscuro,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: todoCtrl.todos.length,
                itemBuilder: (context, index) {
                  final todo = todoCtrl.todos[index];
                  return ListTile(
                    onTap: () {
                      _showPopup(context, todo);
                    },
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (value) {
                        if (value == true) {
                          _showConfirmationModal(context, todo);
                        } else {
                          todoCtrl.onChangeCompletedTodo(todo);
                        }
                      },
                    ),
                    title: Text(todo.title),
                    subtitle: Text(todo.description ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteModal(context, todo);
                      },
                    ),
                  );
                }),
          )
        ],
      );
    });
  }
}

void _showPopup(BuildContext context, TodoModel todo) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return TodoDetailsPopup(todo: todo);
      });
}

void _showAddTodoModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      width: double.infinity,
      height: 800,
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: const AddTodoForm(),
    ),
    isScrollControlled: true,
  );
}

void _showDeleteModal(BuildContext context, TodoModel todo) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
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
                                todoCtrl.onRemoveTodo(todo);
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
      });
}



void _showConfirmationModal(BuildContext context, TodoModel todo) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
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
                                todoCtrl.onChangeCompletedTodo(todo);
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
      });
}
