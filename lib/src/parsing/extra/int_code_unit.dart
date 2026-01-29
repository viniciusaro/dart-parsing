import 'package:parsing/parsing.dart';

class IntParserCodeUnit with Parser<int, Iterable<int>> {
  @override
  (int, Iterable<int>) run(Iterable<int> input) {
    int matchesCount = 0;
    for (var i = 0; i < input.length; i++) {
      final unit = input.elementAt(i);
      if (unit < 48 || unit > 57) break;
      matchesCount++;
    }

    try {
      final intResult = int.parse(
        String.fromCharCodes(input.take(matchesCount)),
      );
      final result = input.skip(matchesCount);
      return (intResult, result);
    } catch (e) {
      throw ParserError(
        expected: "Int",
        remainingInput: "unavailable",
      );
    }
  }
}
