import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../presentations/controllers/todocontroller.dart';
import '../constants/colors.dart';
import '../presentations/models/todolist.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  DateTime? selectedData;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleTEC.dispose();
    descriptionTEC.dispose();
    super.dispose();
  }

  void onAddTodo(TodoController todoCtrl) {
    if (formKey.currentState!.validate()) {
      if (!_isValidDate(selectedData)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data inválida'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final TodoModel newTodo = TodoModel(
        titleTEC.text,
        descriptionC: descriptionTEC.text,
        dateC: selectedData,
      );
      todoCtrl.addTodo(newTodo);
      print(newTodo);
    }
  }

  bool _isValidDate(DateTime? date) {
    return date != null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedData = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(
      builder: (context, todoCtrl, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: roxoBase,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Adicionar nova atividade',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: titleTEC,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Título',
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: descriptionTEC,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Descrição',
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(text: selectedData != null ? DateFormat('dd/MM/yyyy').format(selectedData!): ''),
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          labelText: 'Data',
                                          labelStyle: TextStyle(color: Colors.white),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          onAddTodo(todoCtrl);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: const Text(
                                          'Adicionar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
