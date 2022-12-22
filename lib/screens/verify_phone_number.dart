// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc_signin_with_phone/screens/home_screen.dart';

class VerfiyNumberScreen extends StatelessWidget {
  const VerfiyNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone number"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLength: 20,
                    controller: otpCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "6 digit OTP",
                        counterText: ""),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoggedInState) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                            duration: Duration(milliseconds: 600),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          child: Text("Verify"),
                          color: Colors.blue,
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context)
                                .verifyOTP(otpCtrl.text);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
