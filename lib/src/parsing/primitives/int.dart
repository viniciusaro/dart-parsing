part of '../parsing.dart';

class IntParser with Parser<int, IterableCollection<int>> {
  @override
  (int, IterableCollection<int>) run(IterableCollection<int> input) {
    final parser = Prefix<IterableCollection<int>, int>(
      (unit) => unit >= 48 && unit <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.iterable)), rest);
  }
}

class IntParserString with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    final parser = Prefix<StringSlice, int>((unit) {
      return unit >= 48 && unit <= 57;
    });
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.iterable)), rest);
  }
}
