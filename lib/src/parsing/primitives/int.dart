part of '../parsing.dart';

class IntParser with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    int matchesCount = 0;
    for (var i = 0; i < input.length; i++) {
      final unit = input.codeUnitAt(i);
      if (unit < 48 || unit > 57) break;
      matchesCount++;
    }

    try {
      final intResult = int.parse(input.taking(matchesCount).toString());
      input.skip(matchesCount);
      return (intResult, input);
    } catch (e) {
      throw ParserError(
        expected: "Int",
        remainingInput: "unavailable",
      );
    }
  }
}
