import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Text(
          'Selamat datang di Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
