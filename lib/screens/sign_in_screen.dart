// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc_signin_with_phone/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc_signin_with_phone/screens/verify_phone_number.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in with Phone"),
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
                    controller: phoneCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        counterText: ""),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthCodeSentState) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => VerfiyNumberScreen(),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CupertinoButton(
                            child: Text("Sign In"),
                            color: Colors.blue,
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .sendOTP(phoneCtrl.text);
                            },
                          ),
                        );
                      }
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
