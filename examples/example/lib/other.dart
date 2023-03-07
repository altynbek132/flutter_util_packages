Future<void> main() async {
  final list = List.generate(20, (i) => i)..shuffle();
  list.sort((a, b) => a - b);
  print(list);
}
