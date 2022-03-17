import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/bloc/names_cubit.dart';
import 'package:bloc_vs_washington/ui/names_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NamesCubit(NameService()),
      child: MaterialApp(
        title: 'Bloc Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<NamesCubit, Set<String>>(
          builder: (context, state) {
            return NamesPage(
              title: 'Names',
              names: state.toList(),
              onGenerateNamePressed: (context) async => await context.read<NamesCubit>().generateName(),
            );
          },
        ),
      ),
    );
  }
}
