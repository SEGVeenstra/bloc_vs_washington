import 'dart:math';

class NameService {
  static final _random = Random();

  final _firstNames = ['Stephan', 'Thomas', 'Lennard', 'Matthias', 'Lorenzo', 'Alex'];
  final _lastNames = ['Veenstra', 'Middel', 'Deurman', 'Helder', 'Velasco Sánchez', 'Caskey'];

  Future<String> generateName() async {
    await Future.delayed(const Duration(milliseconds: 350));
    final firstName = _firstNames[_random.nextInt(_firstNames.length)];
    final lastName = _lastNames[_random.nextInt(_lastNames.length)];

    return '$firstName $lastName';
  }
}
