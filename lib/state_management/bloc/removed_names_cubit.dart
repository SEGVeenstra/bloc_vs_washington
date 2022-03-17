import 'dart:async';

import 'package:bloc_vs_washington/state_management/bloc/names_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../helpers/set_ext.dart';

class RemovedNamesCubit extends Cubit<Set<String>> {
  final NamesCubit _namesCubit;
  late StreamSubscription _subscription;

  RemovedNamesCubit(this._namesCubit) : super({}) {
    _subscription = _namesCubit.stream.listen(
      (namesState) {
        Set<String> newNames = Set.of(state);
        if (namesState is NamesStateNameRemoved) {
          newNames.add(namesState.removedName);
        }

        newNames.removeWhere((name) => namesState.names.contains(name));

        emit(newNames.sortAlphabetical());
      },
    );
  }

  Future<void> reAddName(String name) async {
    await _namesCubit.addName(name);

    final newRemovedNames = Set.of(state)..remove(name);

    emit(newRemovedNames);
    _namesCubit.addName(name);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
