import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Container(
                width: double.infinity,
                  child: Image.asset("assets/iti.png",)),
            ),
            Text('ITI',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
                style: TextStyle(fontSize: 14),),
            ),
            MaterialButton(onPressed: (){
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Login(),
                ),
                    (route) => false,//if you want to disable back feature set to false
              );
            },child:
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text("GO",style: TextStyle(fontSize: 18,color: Colors.white),)),
                ),
              ),)

          ],
        ),
      ),
    );
  }
}
