import 'package:check/constants/colors.dart';
import 'package:check/presentations/models/todolist.dart';
import 'package:check/presentations/screens/home_screen.dart';
import 'package:check/widgets/logobackground.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/todocontroller.dart';

class TodoDetailsScreen extends StatelessWidget{
  final TodoModel todo;
  const TodoDetailsScreen({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    final todoCtrl = Provider.of<TodoController>(context);
    return Consumer<TodoController>(
      builder: (context, todoCtrl, child){
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: BackgroundScreen(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      _buildRow('Data:', DateFormat('dd/MM/yyyy').format(todo.date!)),
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      }
    );
  }
}


Widget _buildRow(String label, String text, {Color? color}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color ?? Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container( // Container para o Divider
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const Divider(
          color: roxoEscuro,
          height: 20,
          thickness: 2,
        ),
      ),
    ],
  );
}
