import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Uri _url = Uri.parse('https://www.iti.gov.eg/iti/home');


  Future<void> _launchUrl() async {
    if (!await launchUrl(_url,mode: LaunchMode.externalApplication)) {
      print('Could not launch $_url');
    }}
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ElevatedButton(
          onPressed: _launchUrl,
          child: Text('Show ITI homepage'),
        ),
      ),
    );
  }
}
