import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../helpers/set_ext.dart';

class NamesCubit extends Cubit<Set<String>> {
  final NameService _nameService;

  NamesCubit(this._nameService) : super({});

  Future<void> generateName() async {
    final newName = await _nameService.generateName();

    // Add the new name
    final newState = Set.of(state)..add(newName);

    // Sort on alphabetical order
    final sortedState = newState.sortAlphabetical();

    emit(sortedState);
  }
}
