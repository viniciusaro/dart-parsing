part of 'parsing.dart';

class StringLiteral with Parser<IterableCollection<int>, String> {
  final String literal;
  final List<int> literalCodeUnits;

  StringLiteral(this.literal) : literalCodeUnits = literal.codeUnits;

  @override
  (String, IterableCollection<int>) run(IterableCollection<int> input) {
    if (input.source.startsWith(literalCodeUnits)) {
      final result = literal;
      final rest = input.removeFirst(literalCodeUnits.length);
      return (result, rest);
    }
    throw ParserError(
      expected: literal,
      remainingInput: input.source,
    );
  }
}
