import 'package:flutter/material.dart';
import 'package:prueba_integradora/screens/login_screen.dart';
import 'package:prueba_integradora/screens/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold( 
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              "Vic's Cows",
              style: TextStyle(
                color: const Color.fromRGBO(44, 5, 5, 1),
                fontSize: size.width * 0.08, 
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
                fontFamily: 'EB Garamond',
              ),
              textAlign: TextAlign.center, 
            ),
            SizedBox(height: size.height * 0.05), 
            Expanded( 
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Image.asset(
                  "assets/images/welcome.png",
                  fit: BoxFit.contain, 
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Material(
                    color: const Color.fromRGBO(44, 5, 5, 1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.03,
                        ),
                        child: FittedBox( 
                          child: Text(
                            "Iniciar sesión",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05, 
                              fontWeight: FontWeight.bold,
                              fontFamily: 'EB Garamond',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Material(
                    color: const Color.fromRGBO(191, 101, 57, 1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.03,
                        ),
                        child: FittedBox(
                          child: Text(
                            "Registrarse",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'EB Garamond',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
