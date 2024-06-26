import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/login_screen.dart';
import 'package:rental_ps/Screen/signup_screen.dart';
import 'package:rental_ps/widgets/my_button.dart';
import 'config_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

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
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const Text(
                "Garage PlayStation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Rental Ps Take Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/pslogo.png",
                width: 300,
              ),
              const SizedBox(height: 100),
              MyButton(
                customColor: Colors.indigoAccent,
                text: "Login",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                customColor: Colors.white,
                text: "Register",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpFormScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfigScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.wifi),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
