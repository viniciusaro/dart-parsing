import 'package:dart_parsing/dart_parsing.dart';

import 'slices.dart';

class IntParserSlice with Parser<int, MutableStringSlice> {
  @override
  (int, MutableStringSlice) run(MutableStringSlice input) {
    int matchesCount = 0;
    for (var i = 0; i < input.length; i++) {
      final unit = input.codeUnitAt(i);
      if (unit < 48 || unit > 57) break;
      matchesCount++;
    }

    try {
      final intResult = int.parse(input.take(matchesCount).toString());
      input.skiping(matchesCount);
      return (intResult, input);
    } catch (e) {
      throw ParserError(
        expected: "Int",
        remainingInput: "unavailable",
      );
    }
  }
}
