import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/washington/names_state.dart';
import 'package:bloc_vs_washington/state_management/washington/user_actions.dart';
import 'package:bloc_vs_washington/ui/names_page.dart';
import 'package:flutter/material.dart';
import 'package:washington/washington.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      create: (_) => NamesState(NameService()),
      child: MaterialApp(
        title: 'Washington Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StateBuilder<NamesState>(
          builder: (context, state) {
            return NamesPage(
              title: 'Names',
              names: state.value.toList(),
              onGenerateNamePressed: (_) => Washington.instance.dispatch(GenerateNamePressed()),
            );
          },
        ),
      ),
    );
  }
}
