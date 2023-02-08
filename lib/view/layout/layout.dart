
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti/view/layout/favorite.dart';
import 'package:iti/view/layout/home.dart';
import 'package:iti/view/layout/profile.dart';
import 'package:iti/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex =0;
  List<Widget> screens=[
    Home(),
    Favorite(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ITI",),
      ),
      body: screens[currentIndex],
      floatingActionButton: currentIndex==2?FloatingActionButton(
        child: Icon(CupertinoIcons.arrow_right_to_line_alt),
        onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final success = await prefs.remove('email');
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const Login(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );

      },):null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt),label: "HOME"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart_fill),label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: "Profile"),
      ],

      ),
    );
  }
}
