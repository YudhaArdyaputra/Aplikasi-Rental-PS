import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_ps/Screen/home_screen.dart';
import 'package:rental_ps/Screen/splash.dart';
import 'package:rental_ps/Screen/home_admin.dart';
import 'package:rental_ps/Screen/login_screen.dart';
import 'package:rental_ps/cubit/auth/auth_cubit.dart';
import 'package:rental_ps/cubit/auth/datalogin/cubit/data_login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<DataLoginCubit>(create: (context) => DataLoginCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(),
          initialRoute: "/",
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const HomeScreen(),
            '/admin': (context) => const HomeScreenAdmin(),
            '/login-screen': (context) => const LoginScreen(),
          },
        ));
  }
}
