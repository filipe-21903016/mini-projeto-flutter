import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../models/entry.dart';
import '../widgets/radio_button.dart';

class EntryDetailsScreen extends StatelessWidget {
  final Entry entry;

  const EntryDetailsScreen({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observationsController = TextEditingController();
    observationsController.text = entry.notes.isEmpty
        ? "Não existem observações para este registo"
        : entry.notes;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0XFFF4F9FF),
        appBar: AppBar(
          leading: IconButton(
              color: const Color(0xFF6FB1FF),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const GradientText(
            "Detalhes",
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Qual é o teu peso?",
                        style: TextStyle(
                          color: Color(0xFF6FB1FF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      "${entry.weight.toStringAsFixed(2)} kg",
                      style: const TextStyle(
                          color: Color(0xFF6FB1FF),
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Como te sentes hoje?",
                        style:
                            TextStyle(color: Color(0xFF6FB1FF), fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${entry.feel}",
                            style: const TextStyle(
                                color: Color(0xFF6FB1FF),
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Alimentou-se nas últimas 3 horas?",
                        style:
                            TextStyle(color: Color(0xFF6FB1FF), fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomRadioButton(
                            isSelected: entry.fed,
                            text: "Sim",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomRadioButton(
                            isSelected: !entry.fed,
                            text: "Não",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    style: const TextStyle(
                      color: Color(0xFF6FB1FF),
                    ),
                    controller: observationsController,
                    enabled: false,
                    decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6FB1FF),
                        ),
                      ),
                      label: Text(
                        "Observações",
                        style: TextStyle(
                          color: Color(0xFF6FB1FF),
                        ),
                      ),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6FB1FF),
                        ),
                      ),
                    ),
                    maxLength: 200,
                    maxLines: 7,
                    minLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  entry.dateTime,
                  style: const TextStyle(
                    color: Color(0xff878787),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
* TextField(
                    controller: observationsController,
                    enabled: false,
                    decoration: const InputDecoration(
                      label: Text("Observações"),
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 200,
                    maxLines: 7,
                    minLines: 1,
                  ),*/
