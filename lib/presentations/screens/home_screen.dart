import 'package:check/presentations/screens/screen02.dart';
import 'package:flutter/material.dart';
import 'package:check/constants/colors.dart';
import 'package:signals/signals.dart';
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
        body: Watch.builder(
          builder: (context, todos) {
            if (todos.isEmpty) {
              return const Screen01();
            }
            return const Screen02();
          },
          signal: todoCtrl.todos,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (_) => const AddTodoForm());
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


// floatingActionButton: FloatingActionButton(
//         onPressed: () {
//
//         },
//         elevation: 3,
//         backgroundColor: roxoBase,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//         ),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),

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

