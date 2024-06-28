import 'package:parsing/parsing.dart';

class StringStartsWith with Parser<String, String> {
  final Pattern start;

  StringStartsWith(this.start);

  @override
  (String, String) run(String input) {
    String toString(dynamic value) {
      if (value is RegExp) {
        return value.firstMatch(input)!.group(0)!;
      } else {
        return value.toString();
      }
    }

    if (input.startsWith(start)) {
      final result = toString(start);
      final rest = input.substring(result.length);
      return (result, rest);
    }
    throw ParserError(expected: toString(start), remainingInput: input);
  }
}
