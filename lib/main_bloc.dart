import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/bloc/names_cubit.dart';
import 'package:bloc_vs_washington/state_management/bloc/removed_names_cubit.dart';
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
    final namesCubit = NamesCubit(NameService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => namesCubit),
        BlocProvider(create: (_) => RemovedNamesCubit(namesCubit)),
      ],
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
                action: () async => await context.read<RemovedNamesCubit>().reAddName(state.removedName),
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
              nextPage: BlocBuilder<RemovedNamesCubit, Set<String>>(
                builder: (context, state) {
                  return NamesPage(
                    title: 'Removed Names',
                    names: state.toList(),
                    onRemoveNamePressed: (name, context) async {
                      await context.read<RemovedNamesCubit>().reAddName(name);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
