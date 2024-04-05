import 'package:check/presentations/models/todolist.dart';
import 'package:check/presentations/screens/screen01.dart';
import 'package:check/presentations/screens/todoDetails.dart';
import 'package:flutter/material.dart';
import 'package:check/constants/colors.dart';
import 'package:signals/signals_flutter.dart';
import '../../widgets/add_form.dart';
import '../controllers/todocontroller.dart';

final todoCtrl = TodoController();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Watch((context) {
          return todoCtrl.todos.isEmpty
              ? const Screen01()
              : const Screen02();
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
        )
    );
  }
}
AppBar _buildAppBar() {
  return AppBar(
    title: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const InkWell(
              child: Icon(Icons.menu, color: roxoEscuro, size: 30),
            ),
            const Image(image: AssetImage('assets/images/logo.png'), width: 100, height: 100),
            InkWell(
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
                  child: Icon(Icons.person_rounded, color: roxoEscuro, size: 25),
                ),
              ),
            ),
          ],
        )
    ),
  );
}



class Screen02 extends StatelessWidget {
  const Screen02({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context){
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
                  return  ListTile(
                    onTap: () {
                      _showPopup(context, todo);
                    },
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) {
                        todoCtrl.onChangeCompletedTodo(todo);
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


void _showPopup (BuildContext context, TodoModel todo){
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

void _showDeleteModal(BuildContext context, TodoModel todo){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja excluir essa tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                todoCtrl.onRemoveTodo(todo);
                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      });
}