part of 'parsing.dart';

class IntParser with Parser<IterableCollection<int>, int> {
  @override
  (int, IterableCollection<int>) run(IterableCollection<int> input) {
    final parser = Prefix<IterableCollection<int>, int>(
      (unit) => unit >= 48 && unit <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.iterable)), rest);
  }
}

class IntParserString with Parser<StringSlice, int> {
  @override
  (int, StringSlice) run(StringSlice input) {
    final parser = Prefix<StringSlice, int>((unit) {
      return unit >= 48 && unit <= 57;
    });
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.iterable)), rest);
  }
}
