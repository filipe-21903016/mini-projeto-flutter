import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_que_peso/blocs/entry_bloc.dart';
import 'package:i_que_peso/services/data_service.dart';
import '../../models/entry.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EntryBloc, EntryState>(
      listener: (context, state) {},
      child: Dismissible(
        confirmDismiss: (DismissDirection dismissDirection) async {
          if (dismissDirection == DismissDirection.endToStart) {
            if (!DataService.verifyDelete(entry)) {
              context.read<EntryBloc>().add(FailedDeleteEvent());
              return false;
            }
            return true;
          }
          return false;
        },
        background: Container(),
        secondaryBackground: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.delete_outlined,
              color: Colors.red.shade700,
            ),
          ),
        ),
        key: Key(entry.hashCode.toString()),
        onDismissed: (direction) {
          context.read<EntryBloc>().add(DeleteEntryEvent(entry: entry));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF6FB1FF), Color(0xFF93A4FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${entry.weight.toString()} kg",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Color(0XFFF4F9FF),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: List.generate(
                            entry.feel,
                            (index) => const Icon(
                              Icons.sentiment_satisfied_alt_outlined,
                              color: Color(0XFFF4F9FF),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        entry.dateTime,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0XFFF4F9FF),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 28,
                            color: Color(0XBBF4F9FF),
                          ),
                          onPressed: () {
                            context
                                .read<EntryBloc>()
                                .add(TryEditEvent(entry: entry));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
