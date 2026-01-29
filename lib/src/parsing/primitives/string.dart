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
      remainingInput: input.iterable,
    );
  }
}
