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
