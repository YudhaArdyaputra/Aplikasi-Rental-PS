import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/HomeScreen.dart';
import 'package:rental_ps/widgets/myButtom.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool showPass = false;
  bool checkTheBox = false;

  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  void check() {
    setState(() {
      checkTheBox = !checkTheBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                "WELCOME TO DAVE GAMING",
                style: TextStyle(),
              ),
              SizedBox(
                height: 60,
              ),
              Image.asset(
                "assets/images/gaming.png",
                width: 200,
              ),
              SizedBox(height: 100),
              MyButton(
                customColor: Color.fromARGB(255, 0, 236, 114),
                text: "Login",
                onTap: () {
                  // Navigasi ke HomeScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              MyButton(
                customColor: Color.fromARGB(255, 141, 141, 141),
                text: "Sign In",
                onTap: () {
                  // Navigasi ke HomeScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
