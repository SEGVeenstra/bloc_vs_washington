import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../helpers/set_ext.dart';

part 'names_state.dart';

class NamesCubit extends Cubit<NamesState> {
  final NameService _nameService;

  NamesCubit(this._nameService) : super(NamesStateLoaded(names: {}));

  Future<void> generateName() async {
    emit(NamesStateLoading(names: state.names));

    final newName = await _nameService.generateName();

    if (state.names.contains(newName)) {
      emit(
        NamesStateDuplicatedName(
          duplicatedName: newName,
          names: state.names,
        ),
      );
      return;
    }

    // Add the new name
    final newNames = Set.of(state.names)..add(newName);

    // Sort on alphabetical order
    final sortedNames = newNames.sortAlphabetical();

    emit(NamesStateLoaded(names: sortedNames));
  }

  Future<void> removeName(String name) async {
    final newNames = Set.of(state.names)..remove(name);

    emit(
      NamesStateNameRemoved(
        removedName: name,
        names: newNames,
      ),
    );
  }

  Future<void> addName(String name) async {
    final newNames = Set.of(state.names)..add(name);

    final sortedNames = newNames.sortAlphabetical();

    emit(NamesStateLoaded(names: sortedNames));
  }
}
