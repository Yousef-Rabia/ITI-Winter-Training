import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iti/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layout/layout.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isShown=true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ITI",),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text('Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(

                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value)
                    {
                      if(value==null)
                      {return null;}
                      if(value.isEmpty)
                      {return "email address must not be empty";}
                      if(!validateEmail(value))
                      {return "email address not valid";}
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          print("lol");
                          isShown=!isShown;
                          setState(() {
                          });
                        },
                        icon: Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
                    obscureText: isShown,
                    validator: (value)
                    {

                      if(value!.isEmpty)
                      {return "password must not be empty";}
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    width: double.infinity,

                    child: MaterialButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {

                          if(formKey.currentState!.validate()) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('email',emailController.text);

                            try {
                              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              if(credential!=null){
                                Fluttertoast.showToast(
                                    msg: "Welcome",
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                                Navigator.pushAndRemoveUntil<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) => Layout(),
                                  ),
                                      (route) => false,//if you want to disable back feature set to false
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                Fluttertoast.showToast(
                                    msg: "email not found",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else if (e.code == 'wrong-password') {
                                Fluttertoast.showToast(
                                    msg: "Wrong password",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
                          }
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account"),
                      TextButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register()),
                        );

                      }, child: Text('Register Now'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );

  }
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
