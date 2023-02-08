import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Register'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black)
                  ),
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
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    onFieldSubmitted: (value){
                      // if(formKey.currentState!.validate())
                      // {
                      //   ShopRegisterCubit.get(context).userRegister(
                      //       nameController.text,
                      //       emailController.text,
                      //       phoneController.text,
                      //       passwordController.text
                      //   );
                      //
                      // }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
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
                    color: Colors.red,
                    width: double.infinity,
                    child: MaterialButton(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {

                          if(formKey.currentState!.validate())
                          {
                            try {
                              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              Fluttertoast.showToast(
                                  msg: "Register Successfully",
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pop(context);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Fluttertoast.showToast(
                                    msg: "Password is too weak.",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(
                                    msg: "Email already exists",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            } catch (e) {
                              print(e);
                            }

                          }
                        }
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
