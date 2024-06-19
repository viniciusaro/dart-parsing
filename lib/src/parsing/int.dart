part of 'parsing.dart';

class IntParser with Parser<String, int> {
  IntParser();

  @override
  (int, String) run(String input) {
    return StringPrefix(r'\d+').map(int.parse).run(input);
  }
}
