import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../controllers/todocontroller.dart';


class Screen01 extends StatelessWidget {
  const Screen01({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCtrl = Provider.of<TodoController>(context);
    return Consumer(
      builder: (context, todoCtrl, child){
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: const <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Olá, seja bem-vindo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image(
                    image: AssetImage('assets/images/vetor.png'),
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma atividade foi criada ainda. \nClique no + para adicionar uma atividade.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
