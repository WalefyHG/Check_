import 'package:check/presentations/models/todolist.dart';
import 'package:check/presentations/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget{
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final titleTEC = TextEditingController();
  final descriptionTEC = TextEditingController();
  final dateTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onAddTodo(){
    if(formKey.currentState!.validate()){
      final todoToAdd = TodoModel(
        titleTEC.text,
        descriptionC: descriptionTEC.text,
      );
      todoCtrl.addTodo(todoToAdd);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: titleTEC,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionTEC,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: dateTEC,
              decoration: const InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: onAddTodo,
              child: const Text('Adicionar'),
            ),
          ],
        )
      )
    );
  }

}