import 'package:bloc_vs_washington/services/name_service.dart';
import 'package:bloc_vs_washington/state_management/washington/user_actions.dart';
import 'package:washington/washington.dart';

import './../../helpers/set_ext.dart';

class NamesState extends UnitedState<Set<String>> {
  final NameService _nameService;

  NamesState(this._nameService) : super({}) {
    addHandler<GenerateNamePressed>((_) => _generateNamePressedHandler());
    addHandler<RemoveNamePressed>(_removeNamePressedHandler);
  }

  void _generateNamePressedHandler() async {
    setState(value, isLoading: true);

    final newName = await _nameService.generateName();

    // Add the new name
    final newValue = Set.of(value)..add(newName);

    // Sort on alphabetical order
    final sortedValue = newValue.sortAlphabetical();

    setState(sortedValue);
  }

  Future<void> _removeNamePressedHandler(RemoveNamePressed event) async {
    final newNames = Set.of(value)..remove(event.name);

    setState(newNames);
  }
}
