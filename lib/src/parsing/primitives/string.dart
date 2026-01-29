part of '../parsing.dart';

final class StringLiteral with Parser<StringSlice, StringSlice> {
  final StringSlice literalSlice;

  StringLiteral(String literalSlice)
      : this.literalSlice = StringSlice(literalSlice);

  @override
  (StringSlice, StringSlice) run(StringSlice input) {
    if (input.startsWith(literalSlice)) {
      final result = literalSlice;
      final rest = input.removeFirst(literalSlice.length);
      return (result, rest);
    }
    throw ParserError(
      expected: literalSlice.toString(),
      remainingInput: input.toString(),
    );
  }
}

final class StringThrough with Parser<StringSlice, StringSlice> {
  final StringSlice literal;

  StringThrough(String literal) : this.literal = literal.slice;

  @override
  (StringSlice, StringSlice) run(StringSlice input) {
    int literalIndex = 0;

    for (int inputIndex = 0; inputIndex < input.length; inputIndex++) {
      if (input.iterable.elementAt(inputIndex) ==
          literal.iterable.elementAt(literalIndex)) {
        literalIndex++;
      }
      if (literalIndex == literal.length) {
        final result = input.prefix(inputIndex + 1);
        final rest = input.removeFirst(inputIndex + 1);
        return (result, rest);
      }
    }
    throw ParserError(
      expected: input.toString(),
      remainingInput: input.toString(),
    );
  }
}

class StringLiteralNormalized with Parser<StringSlice, StringSlice> {
  final String literal;

  StringLiteralNormalized(this.literal);

  @override
  Parser<StringSlice, StringSlice> body() {
    return OneOfLazy([
      () => StringLiteral(unorm.nfc(literal)),
      () => StringLiteral(unorm.nfd(literal)),
      () => StringLiteral(unorm.nfkc(literal)),
      () => StringLiteral(unorm.nfkd(literal)),
    ]);
  }
}
