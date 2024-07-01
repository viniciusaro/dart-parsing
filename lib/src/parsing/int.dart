part of 'parsing.dart';

class IntParser with Parser<IterableCollection<int>, int> {
  @override
  (int, IterableCollection<int>) run(IterableCollection<int> input) {
    final parser = Prefix<IterableCollection<int>, int>(
      (unit) => unit >= 48 && unit <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.source)), rest);
  }
}

class IntParserString with Parser<StringCollection, int> {
  @override
  (int, StringCollection) run(StringCollection input) {
    final parser = Prefix<StringCollection, int>(
      (unit) => unit >= 48 && unit <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.source)), rest);
  }
}
