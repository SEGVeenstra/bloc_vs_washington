import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/bloc/names_cubit.dart';
import 'package:bloc_vs_washington/ui/names_page.dart';
import 'package:bloc_vs_washington/ui/names_snackbar.dart';
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
        home: BlocConsumer<NamesCubit, NamesState>(
          listener: (context, state) {
            if (state is NamesStateDuplicatedName) {
              showNamesSnackbar(
                context: context,
                text: '${state.duplicatedName} was already added.',
              );
            } else if (state is NamesStateNameRemoved) {
              showNamesSnackbar(
                context: context,
                text: '${state.removedName} has been removed.',
                action: () async => await context.read<NamesCubit>().addName(state.removedName),
                actionLabel: 'Undo',
              );
            }
          },
          builder: (context, state) {
            return NamesPage(
              title: 'Names',
              isLoading: state is NamesStateLoading,
              names: state.names.toList(),
              onGenerateNamePressed: (context) async => await context.read<NamesCubit>().generateName(),
              onRemoveNamePressed: (name, context) async => context.read<NamesCubit>().removeName(name),
            );
          },
        ),
      ),
    );
  }
}
