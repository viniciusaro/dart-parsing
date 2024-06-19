part of 'parsing.dart';

class IntParser with Parser<String, int> {
  @override
  Parser<String, int> body() {
    return StringPrefix(r'\d+').map(int.parse);
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

    final remainingUnits = codeUnits.toList().getRange(
          intUnits.length,
          codeUnits.length,
        );

    final result = int.parse(String.fromCharCodes(remainingUnits));

    return (result, remainingUnits);
  }
}
