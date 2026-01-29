part of '../parsing.dart';

class IntParser with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    List<int> matches = [];

    for (final unicode in input.iterable) {
      if (unicode >= 48 && unicode <= 57) {
        matches.add(unicode);
      } else {
        break;
      }
    }

    final stringRest = input.removeFirst(matches.length);
    final intResult = int.parse(String.fromCharCodes(matches));
    return (intResult, stringRest);
  }
}
