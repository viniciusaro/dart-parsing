part of '../parsing.dart';

class IntParser with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    int matchesCount = 0;
    for (var i = 0; i <= input.length; i++) {
      final unit = input.codeUnitAt(i);
      if (unit < 48 || unit > 57) break;
      matchesCount++;
    }

    final stringRest = input.removeFirst(matchesCount);

    try {
      final intResult = int.parse(
        input.prefix(matchesCount).toString(),
      );
      return (intResult, stringRest);
    } catch (e) {
      throw ParserError(
        expected: input.toString(),
        remainingInput: stringRest.toString(),
      );
    }
  }
}
