import 'package:flutter/material.dart';

class VacasScreen extends StatefulWidget {
  const VacasScreen({super.key});

  @override
  State<VacasScreen> createState() => _VacasScreenState();
}

class _VacasScreenState extends State<VacasScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Bienvenido al apartado Vacas", 
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'EB Garamond',
      ),), ]
    );
  }
}