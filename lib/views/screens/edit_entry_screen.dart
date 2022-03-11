import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:i_que_peso/services/data_service.dart';
import '../../blocs/entry_bloc.dart';
import '../../models/entry.dart';
import '../widgets/radio_button.dart';

class EditEntryScreen extends StatefulWidget {
  final Entry entry;

  const EditEntryScreen({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  late bool newFed;
  late int newFeel;

  final observationsController = TextEditingController();
  final weightController = TextEditingController();

  @override
  initState() {
    newFed = widget.entry.fed;
    newFeel = widget.entry.feel;
    observationsController.text = widget.entry.notes;
    weightController.text = widget.entry.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EntryBloc, EntryState>(
      listener: (context, state) {},
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0XFFF4F9FF),
          appBar: AppBar(
            leading: IconButton(
                color: const Color(0xFF6FB1FF),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<EntryBloc>().add(LoadEntriesEvent());
                  Navigator.pop(context);
                }),
            title: const GradientText(
              "Editar Registo",
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
          body: BlocListener<EntryBloc, EntryState>(
            listener: (context, state) {},
            child: SingleChildScrollView(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextField(
                            style: const TextStyle(
                              color: Color(0xFF6FB1FF),
                            ),
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 5,
                            decoration: const InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF6FB1FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF6FB1FF),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF6FB1FF),
                                ),
                              ),
                            ),
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
                            "Como te sentes hoje?",
                            style: TextStyle(
                                color: Color(0xFF6FB1FF), fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (newFeel > 1) {
                                      newFeel--;
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Color(0xFF6FB1FF),
                                ),
                              ),
                              Text(
                                "$newFeel",
                                style: const TextStyle(
                                    color: Color(0xFF6FB1FF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (newFeel < 5) {
                                      newFeel++;
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFF6FB1FF),
                                ),
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
                            style: TextStyle(
                                color: Color(0xFF6FB1FF), fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    newFed = true;
                                  });
                                },
                                child: CustomRadioButton(
                                  isSelected: newFed,
                                  text: "Sim",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    newFed = false;
                                  });
                                },
                                child: CustomRadioButton(
                                  isSelected: !newFed,
                                  text: "Não",
                                ),
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
                        textInputAction: TextInputAction.go,
                        controller: observationsController,
                        decoration: const InputDecoration(
                          label: Text(
                            "Observações",
                            style: TextStyle(
                              color: Color(0xFF6FB1FF),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF6FB1FF),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF6FB1FF),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
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
                ],
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: FloatingActionButton.extended(
              label: const Text("Submeter"),
              backgroundColor: const Color(0xFF6FB1FF),
              onPressed: () {
                //verify fields correspondent field
                if (DataService.verifyEntryFields(weightController.text,
                    newFeel, newFed, observationsController.text)) {
                  context.read<EntryBloc>().add(
                        EditEntryEvent(
                          entry: widget.entry,
                          newEntry: Entry(
                            weight: double.parse(weightController.text),
                            fed: newFed,
                            feel: newFeel,
                            notes: observationsController.text,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
