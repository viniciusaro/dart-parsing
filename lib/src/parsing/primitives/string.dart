part of '../parsing.dart';

final class StringLiteral with Parser<CodeUnits, CodeUnits> {
  final String literal;
  final CodeUnits codeUnits;

  StringLiteral(this.literal) : this.codeUnits = literal.codeUnits;

  @override
  (CodeUnits, CodeUnits) run(CodeUnits input) {
    if (input.startsWith(codeUnits)) {
      final result = codeUnits;
      final rest = input.skip(codeUnits.length);
      return (result, rest);
    }
    throw ParserError(
      expected: literal,
      remainingInput: input,
    );
  }
}

final class StringThrough with Parser<CodeUnits, CodeUnits> {
  final CodeUnits literal;

  StringThrough(String literal) : this.literal = literal.codeUnits;

  @override
  (CodeUnits, CodeUnits) run(CodeUnits input) {
    int literalIndex = 0;

    for (int inputIndex = 0; inputIndex < input.length; inputIndex++) {
      if (input.elementAt(inputIndex) == literal.elementAt(literalIndex)) {
        literalIndex++;
      }
      if (literalIndex == literal.length) {
        final result = input.take(inputIndex + 1);
        input.skip(inputIndex + 1);
        return (result, input);
      }
    }
    throw ParserError(
      expected: input.toString(),
      remainingInput: input.toString(),
    );
  }
}

class StringLiteralNormalized with Parser<CodeUnits, CodeUnits> {
  final String literal;

  StringLiteralNormalized(this.literal);

  @override
  Parser<CodeUnits, CodeUnits> body() {
    return OneOfLazy([
      () => StringLiteral(unorm.nfc(literal)),
      () => StringLiteral(unorm.nfd(literal)),
      () => StringLiteral(unorm.nfkc(literal)),
      () => StringLiteral(unorm.nfkd(literal)),
    ]);
  }
}
