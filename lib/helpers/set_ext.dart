extension SetExt on Set<String> {
  Set<String> sortAlphabetical() {
    final list = toList();
    list.sort();
    return list.toSet();
  }
}
