import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:prueba_integradora/screens/home_page.dart';
import 'package:prueba_integradora/screens/welcome_screen.dart';
import 'package:prueba_integradora/utils/auth.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool passToggle = true;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthService _auth = AuthService();

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  "Veterinaria Victor's",
                  style: TextStyle(
                    color: Color.fromRGBO(103, 92, 60, 1),
                    fontSize: 34,
                    letterSpacing: 1,
                    wordSpacing: 2,
                    fontFamily: 'EB Garamond',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  child: Image.asset("assets/images/logov.png"),
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(), // Validador de correo electrónico
                        ]),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'user',
                        decoration: InputDecoration(
                          labelText: 'Nombre de Usuario',
                          prefixIcon: Icon(Icons.account_circle_outlined),
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'phone',
                        decoration: InputDecoration(
                          labelText: 'Número telefónico',
                          prefixIcon: Icon(Icons.call),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'address',
                        decoration: InputDecoration(
                          labelText: 'Domicilio',
                          prefixIcon: Icon(Icons.fmd_good_outlined),
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'pass',
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passToggle
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'confirm_pass',
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          labelText: 'Confirme su Contraseña',
                          prefixIcon: Icon(Icons.enhanced_encryption_outlined),
                        ),
                        validator: (val) {
                          if (val != _formKey.currentState?.fields['pass']?.value) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        child: Material(
                          color: Color.fromRGBO(191, 101, 57, 1),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState?.saveAndValidate() == true) {
                                final values = _formKey.currentState?.value;
                                try {
                                  UserCredential result = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: values?['email'],
                                    password: values?['pass'],
                                  );
                                  // Navegar a la pantalla de inicio
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
                                } catch (e) {
                                  // Manejar el error, mostrar un mensaje de error
                                  print(e.toString());
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                              child: Text(
                                "Registrarme",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                            "Ya tengo una cuenta.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Volver",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
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
    );
  }
}
