part of '../parsing.dart';

class IntParser with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    int matchesCount = 0;
    for (var i = input._startIndex; i <= input._endIndex; i++) {
      final unit = input._source.codeUnitAt(i);
      if (unit >= 48 && unit <= 57) {
        matchesCount++;
      } else {
        break;
      }
    }

    final stringRest = input.removeFirst(matchesCount);

    try {
      final intResult = int.parse(
        String.fromCharCodes(input.prefix(matchesCount).iterable),
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
