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

class StringLiteralString with Parser<StringCollection, String> {
  final String literal;
  final Iterable<int> literalCodeUnits;

  StringLiteralString(this.literal) : literalCodeUnits = literal.codeUnits;

  @override
  (String, StringCollection) run(StringCollection input) {
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

class StringLiteralNormalizedString with Parser<StringCollection, String> {
  final String literal;

  StringLiteralNormalizedString(this.literal);

  @override
  Parser<StringCollection, String> body() {
    return OneOfLazy([
      () => StringLiteralString(unorm.nfc(literal)),
      () => StringLiteralString(unorm.nfd(literal)),
      () => StringLiteralString(unorm.nfkc(literal)),
      () => StringLiteralString(unorm.nfkd(literal)),
    ]);
  }
}

class StringThrough
    with Parser<IterableCollection<int>, IterableCollection<int>> {
  final String target;
  final Iterable<int> targetCodeUnits;

  StringThrough(this.target) : targetCodeUnits = target.codeUnits;

  @override
  (IterableCollection<int>, IterableCollection<int>) run(
      IterableCollection<int> input) {
    final count = input.length - targetCodeUnits.length;

    for (var i = 0; i < count; i++) {
      bool found = true;
      final index = i;
      for (var t = 0; t < targetCodeUnits.length; t++, i++) {
        final inputChar = input.source.elementAt(i);
        final targetChar = targetCodeUnits.elementAt(t);
        if (inputChar != targetChar) {
          found = false;
          break;
        }
      }
      if (found) {
        final result = input.source.take(i).collection;
        final rest = input.removeFirst(i);
        return (result, rest);
      }
      i = index;
    }
    throw ParserError(
      expected: target,
      remainingInput: input.source,
    );
  }
}
