import 'package:bloc_vs_washington/state_management/washington/names_state.dart';
import 'package:bloc_vs_washington/state_management/washington/user_actions.dart';
import 'package:washington/washington.dart';

class RemovedNamesState extends UnitedState<Set<String>> {
  RemovedNamesState() : super({}) {
    addHandler<UndoRemoveNamePressed>(_undoRemoveNameHandler);
    addHandler<NameAdded>(_nameAddedHandler);
  }

  void _undoRemoveNameHandler(UndoRemoveNamePressed event) {}

  void _nameAddedHandler(NameAdded event) {}
}
