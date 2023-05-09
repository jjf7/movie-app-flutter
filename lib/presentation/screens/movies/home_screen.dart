import 'package:flutter/material.dart';
import 'package:movie_app/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.themMovieDbKey),
      ),
    );
  }
}
