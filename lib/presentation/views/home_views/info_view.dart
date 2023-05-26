import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Elaborado por JFdeSousa",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Text(
          "jfsistemas.contacto@gmail.com",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ));
  }
}
