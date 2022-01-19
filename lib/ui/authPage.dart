// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/enum/appState.dart';
import 'package:flutter_chat_app/model/authModel.dart';
import 'package:flutter_chat_app/model/authStateModel.dart';
import 'package:flutter_chat_app/ui/baseView.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthModel authModel;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  AuthPage({
    @required this.emailController,
    @required this.passwordController,
    @required this.authModel,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthStateModel>(builder: (context, authStateModel, __) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Form(
                key: formkey,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      TextFormField(
                        validator: (vaule) {
                          RegExp regex = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$");
                          if (vaule.isEmpty) {
                            return "* Required";
                          } else if (!regex.hasMatch(vaule) || vaule == null) {
                            return 'Enter a valid email address';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          } else
                            return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      authModel.viewState == ViewState.Busy
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              child: Text(authStateModel
                                  .switchAuthenticationText(authModel)),
                              color: Colors.lightBlueAccent,
                              onPressed: () async {
                                if (formkey.currentState.validate()) {
                                  authStateModel.switchAuthenticationMethod(
                                      authModel,
                                      emailController,
                                      passwordController);
                                  print("Validated");
                                } else {
                                  print("Not Validated");
                                }
                              }),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          authStateModel.switchAuthenticationState(authModel);
                        },
                        child: Text(authStateModel
                            .switchAuthenticationOption(authModel)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
