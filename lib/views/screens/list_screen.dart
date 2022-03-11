import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:i_que_peso/blocs/entry_bloc.dart';
import 'package:i_que_peso/views/screens/edit_entry_screen.dart';
import 'package:i_que_peso/views/screens/entry_screen.dart';
import 'package:i_que_peso/views/widgets/entry_card.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "Registos",
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
        body: BlocConsumer<EntryBloc, EntryState>(
          listener: (context, state) {
            if (state is NewEntryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("O seu registo foi submetido com sucesso."),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is CanEditState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditEntryScreen(entry: state.entry)));
            }
            if (state is EditedEntryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("O registo selecionado foi editado com sucesso."),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is DeletedEntryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("O registo selecionado foi eliminado com sucesso."),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is CannotEditState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Só podem ser editados registos datados dos últimos 7 dias"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is CannotDeleteState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Só podem ser eliminados registos datados dos últimos 7 dias"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder(
              bloc: BlocProvider.of<EntryBloc>(context),
              builder: (context, state) {
                if (state is LoadEntriesState) {
                  return ListView.builder(
                      itemCount: state.entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  EntryCard(entry: state.entries[index]);
                      });
                }
                return const Center(child: Text("Sometinhg Went Wrong"));
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFCF4F9FF),
          child: const Icon(
            Icons.add,
            color: Color(0xFF6FB1FF),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EntryScreen()),
            );
          },
        ),
      ),
    );
  }
}
