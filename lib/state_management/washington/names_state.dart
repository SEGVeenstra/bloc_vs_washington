import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/washington/user_actions.dart';
import 'package:washington/washington.dart';

import './../../helpers/set_ext.dart';

class DuplicatedNameGenerated {
  final String duplicateName;

  const DuplicatedNameGenerated({required this.duplicateName});
}

class NameRemoved {
  final String removedName;

  const NameRemoved({required this.removedName});
}

class NameAdded {
  final String addedName;

  const NameAdded({required this.addedName});
}

class NamesState extends UnitedState<Set<String>> {
  final NameService _nameService;

  NamesState(this._nameService) : super({}) {
    addHandler<GenerateNamePressed>((_) => _generateNamePressedHandler());
    addHandler<RemoveNamePressed>(_removeNamePressedHandler);
    addHandler<UndoRemoveNamePressed>(_undoRemoveNamePressedHandler);
  }

  void _generateNamePressedHandler() async {
    setState(value, isLoading: true);

    final newName = await _nameService.generateName();

    if (value.contains(newName)) {
      dispatch(DuplicatedNameGenerated(duplicateName: newName));
      setState(value);
      return;
    }

    // Add the new name
    final newValue = Set.of(value)..add(newName);

    // Sort on alphabetical order
    final sortedValue = newValue.sortAlphabetical();

    setState(sortedValue);
    dispatch(NameAdded(addedName: newName));
  }

  Future<void> _removeNamePressedHandler(RemoveNamePressed event) async {
    final newNames = Set.of(value)..remove(event.name);

    setState(newNames);
    dispatch(NameRemoved(removedName: event.name));
  }

  Future<void> _undoRemoveNamePressedHandler(UndoRemoveNamePressed event) async {
    final newValue = Set.of(value)..add(event.name);

    final sortedValue = newValue.sortAlphabetical();

    setState(sortedValue);
    dispatch(NameAdded(addedName: event.name));
  }
}
