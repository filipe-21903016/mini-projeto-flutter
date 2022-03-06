import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iQuePeso"),
      ),
      body: Center(
        child: Text(
          "Ola mundo"
        ),
      ),
    );
  }
}
