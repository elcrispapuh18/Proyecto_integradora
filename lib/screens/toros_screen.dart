import 'package:flutter/material.dart';

class TorosScreen extends StatefulWidget {
  const TorosScreen({super.key});

  @override
  State<TorosScreen> createState() => _TorosScreenState();
}

class _TorosScreenState extends State<TorosScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Bienvenido al apartado Toros", 
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'EB Garamond',
      ),), ]
    );
  }
}