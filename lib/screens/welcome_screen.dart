import 'package:flutter/material.dart';
import 'package:prueba_integradora/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material( 
      child: Container( 
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              "Vic's Pets",
              style: TextStyle(
                color: Color.fromRGBO(191,101,57,1),
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("images/log.png"),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Color.fromRGBO(191,101,57,1),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                    child: Padding(
                      padding:EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Iniciar sesión",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                Material( 
                  color: Color.fromRGBO(191,101,57,1),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                      //
                      //
                      //
                    },
                    child: Padding(
                      padding:EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}