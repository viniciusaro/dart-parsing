part of 'parsing.dart';

class StringLiteral with Parser<IterableCollection<int>, String> {
  final String literal;
  final Iterable<int> literalCodeUnits;

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

class StringLiteralNormalized with Parser<IterableCollection<int>, String> {
  final String literal;

  StringLiteralNormalized(this.literal);

  @override
  Parser<IterableCollection<int>, String> body() {
    return OneOfLazy([
      () => StringLiteral(unorm.nfc(literal)),
      () => StringLiteral(unorm.nfd(literal)),
      () => StringLiteral(unorm.nfkc(literal)),
      () => StringLiteral(unorm.nfkd(literal)),
    ]);
  }
}
