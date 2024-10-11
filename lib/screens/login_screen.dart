import 'package:flutter/material.dart';
import 'package:prueba_integradora/screens/home_page.dart';
import 'package:prueba_integradora/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); 

  
  Future<void> loginUser() async {
    try {
      // Intentar iniciar sesión con Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      // Si tiene éxito, navegar a la pantalla de inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } catch (e) {
      // Si hay un error, mostrar un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al iniciar sesión: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form( // Agregar el Form para validación
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Veterinaria Victor's",
                  style: TextStyle(
                    color: Color.fromRGBO(103, 92, 60, 1),
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 2,
                    fontFamily: 'EB Garamond',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Image.asset("assets/images/logov.png"),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      hintText: 'Correo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su correo electrónico';
                      } else if (!value.contains('@')) {
                        return 'Ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      hintText: 'Contraseña',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      } else if (value.length < 8) {
                        return 'Su contraseña debe tener al menos 8 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: Material(
                    color: Color.fromRGBO(191, 101, 57, 1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Si el formulario es válido, intenta iniciar sesión
                          loginUser();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        child: Text(
                          "Iniciar sesión",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'EB Garamond',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tiene una cuenta?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'EB Garamond',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Registrarse ahora",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontSize: 18,
                          fontFamily: 'EB Garamond',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
