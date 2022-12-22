import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc_signin_with_phone/screens/home_screen.dart';
import 'package:flutter_bloc_signin_with_phone/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const HomeScreen();
            } else if (state is AuthLoggedOutState) {
              return const SignInScreen();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
