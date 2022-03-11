import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:i_que_peso/views/screens/list_screen.dart';

import '../widgets/dashboard_cards.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F9FF),
      appBar: AppBar(
        title: const GradientText(
          "iQuePeso",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          gradient: LinearGradient(
              colors: <Color>[Color(0xFF6FB1FF), Color(0xFF93A4FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: DashboardContent(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Registos"),
        backgroundColor: const Color(0xFF6FB1FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
