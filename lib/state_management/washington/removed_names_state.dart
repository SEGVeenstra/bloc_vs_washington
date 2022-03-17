import 'package:bloc_vs_washington/state_management/washington/names_state.dart';
import 'package:bloc_vs_washington/state_management/washington/user_actions.dart';
import 'package:washington/washington.dart';

import './../../helpers/set_ext.dart';

class RemovedNamesState extends UnitedState<Set<String>> {
  RemovedNamesState() : super({}) {
    addHandler<NameRemoved>(_nameRemovedHandler);
    addHandler<UndoRemoveNamePressed>(_undoRemoveNameHandler);
    addHandler<NameAdded>(_nameAddedHandler);
  }

  void _undoRemoveNameHandler(UndoRemoveNamePressed event) {
    if (value.contains(event.name)) {
      final newNames = Set.of(value)..remove(event.name);
      setState(newNames);
    }
  }

  void _nameAddedHandler(NameAdded event) {
    if (value.contains(event.addedName)) {
      final newNames = Set.of(value)..remove(event.addedName);
      setState(newNames);
    }
  }

  void _nameRemovedHandler(NameRemoved event) {
    final newNames = Set.of(value)..add(event.removedName);

    setState(newNames.sortAlphabetical());
  }
}
