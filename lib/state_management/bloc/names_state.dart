part of 'names_cubit.dart';

abstract class NamesState {
  final Set<String> names;

  const NamesState({required this.names});
}

class NamesStateLoaded extends NamesState {
  NamesStateLoaded({required Set<String> names}) : super(names: names);
}

class NamesStateLoading extends NamesState {
  NamesStateLoading({required Set<String> names}) : super(names: names);
}

class NamesStateNameRemoved extends NamesState {
  final String removedName;

  NamesStateNameRemoved({
    required this.removedName,
    required Set<String> names,
  }) : super(names: names);
}

class NamesStateDuplicatedName extends NamesState {
  final String duplicatedName;

  NamesStateDuplicatedName({
    required this.duplicatedName,
    required Set<String> names,
  }) : super(names: names);
}
