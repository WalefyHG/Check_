import 'package:check/presentations/models/todolist.dart';
import 'package:check/presentations/screens/screen01.dart';
import 'package:check/presentations/screens/screen02.dart';
import 'package:check/presentations/screens/todoDetails.dart';
import 'package:check/widgets/clearing_modal.dart';
import 'package:check/widgets/delete_modal.dart';
import 'package:flutter/material.dart';
import 'package:check/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../widgets/add_form.dart';
import '../../widgets/confirmation_modal.dart';
import '../controllers/todocontroller.dart';
import 'about.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCtrl = Provider.of<TodoController>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(),
      body: SafeArea(
        child: Consumer<TodoController>(
          builder: (context, todoCtrl, child) {
            if (todoCtrl.todos.isEmpty) {
              return const Screen01();
            } else {
              return const Screen02();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTodoModal(context);
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

void showAddTodoModal(BuildContext context) {
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

void showDeleteModal(BuildContext context, TodoModel todo) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeletingModal(todo: todo);
      });
}

void showModalClear(BuildContext context, TodoModel todo){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClearingModal(todo: todo);
      }
  );
}

void showConfirmationModal(BuildContext context, TodoModel todo){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return ConfirmationModal(todo: todo);
      }
  );
}