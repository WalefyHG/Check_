import 'package:flutter/material.dart';
import '../../constants/colors.dart';


class Screen01 extends StatelessWidget {
  const Screen01({Key? key});

  @override
  Widget build(BuildContext context) {
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
                  color: roxoEscuro,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Espaço entre o texto e a imagem
              Image(
                image: AssetImage('assets/images/vetor.png'),
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20), // Espaço entre a imagem e o texto
              Text(
                'Nenhuma atividade foi criada ainda. \nClique no + para adicionar uma atividade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: roxoEscuro,
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
}
