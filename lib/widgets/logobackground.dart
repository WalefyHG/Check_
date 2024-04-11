import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BackgroundScreen extends StatelessWidget{
  final Widget child;
  const BackgroundScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 300,
              )
            )
          ),
        ),
        child,
      ],
    );
  }
}