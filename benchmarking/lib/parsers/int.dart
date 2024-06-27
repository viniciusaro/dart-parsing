import 'package:parsing/parsing.dart';

class IntParserStringPrefix with Parser<String, int> {
  @override
  Parser<String, int> body() {
    return StringPrefix(
      (char) => char.codeUnits.first >= 48 && char.codeUnits.first <= 57,
    ).map(int.parse);
  }
}

class IntParserRunesPrefix with Parser<IterableCollection<int>, int> {
  @override
  (int, IterableCollection<int>) run(IterableCollection<int> input) {
    final parser = Prefix<IterableCollection<int>, int>(
      (rune) => rune >= 48 && rune <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.source)), rest);
  }
}

class IntParserBytesPrefix with Parser<IterableCollection<int>, int> {
  @override
  (int, IterableCollection<int>) run(IterableCollection<int> input) {
    final parser = Prefix<IterableCollection<int>, int>(
      (rune) => rune >= 48 && rune <= 57,
    );
    final (result, rest) = parser.run(input);
    return (int.parse(String.fromCharCodes(result.source)), rest);
  }
}

class IntParserRegex with Parser<String, int> {
  @override
  (int, String) run(String input) {
    final regex = RegExp(r'\d+');
    final match = regex.matchAsPrefix(input);
    final group = match?.group(0) ?? "";
    final rest = input.substring(group.length, input.length);
    return (int.parse(group), rest);
  }
}

class IntParserCodeUnits with Parser<Iterable<int>, int> {
  @override
  (int, Iterable<int>) run(Iterable<int> input) {
    final codeUnits = input;
    final intUnits = codeUnits.takeWhile((unit) => unit >= 48 && unit <= 57);

    if (intUnits.isEmpty) {
      throw ParserError(expected: "an integer", remainingInput: input);
    }

    final remainingUnits = codeUnits.skip(intUnits.length);
    final result = int.parse(String.fromCharCodes(intUnits));
    return (result, remainingUnits);
  }
}
