import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();

  }
  getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    email=prefs.getString('email')!;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Email:"+email),
    );
  }
}
