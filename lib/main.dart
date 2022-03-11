import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_que_peso/blocs/entry_bloc.dart';
import 'package:i_que_peso/views/screens/dashboard_screen.dart';

void main() {
  runApp(const IQuePeso());
}

class IQuePeso extends StatelessWidget {
  const IQuePeso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => EntryBloc()..add(LoadEntriesEvent()),
        ),
      ],
      child: const MaterialApp(
        title: "iQuePeso",
        home: DashBoardScreen(),
      ),
    );
  }
}

