part of 'parsing.dart';

class IntParser with Parser<String, int> {
  IntParser();

  @override
  Parser<String, int> body() {
    return StringPrefix(r'\d+').map(int.parse);
  }
}
