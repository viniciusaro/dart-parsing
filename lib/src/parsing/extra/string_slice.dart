import 'package:dart_parsing/dart_parsing.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

import 'slices.dart';

final class StringLiteralSlice
    with Parser<MutableStringSlice, MutableStringSlice> {
  final String literal;
  final MutableStringSlice literalSlice;

  StringLiteralSlice(this.literal)
      : this.literalSlice = MutableStringSlice(literal);

  @override
  (MutableStringSlice, MutableStringSlice) run(MutableStringSlice input) {
    if (input.startsWith(literalSlice)) {
      final result = literalSlice;
      input.skiping(literalSlice.length);
      return (result, input);
    }
    throw ParserError(
      expected: literal,
      remainingInput: input,
    );
  }
}

final class StringThroughSlice
    with Parser<MutableStringSlice, MutableStringSlice> {
  final MutableStringSlice literal;

  StringThroughSlice(String literal)
      : this.literal = MutableStringSlice(literal);

  @override
  (MutableStringSlice, MutableStringSlice) run(MutableStringSlice input) {
    int literalIndex = 0;

    for (int inputIndex = 0; inputIndex < input.length; inputIndex++) {
      if (input.codeUnitAt(inputIndex) == literal.codeUnitAt(literalIndex)) {
        literalIndex++;
      }
      if (literalIndex == literal.length) {
        final result = input.take(inputIndex + 1);
        input.skiping(inputIndex + 1);
        return (result, input);
      }
    }
    throw ParserError(
      expected: input.toString(),
      remainingInput: input.toString(),
    );
  }
}

class StringLiteralSliceNormalized
    with Parser<MutableStringSlice, MutableStringSlice> {
  final String literal;

  StringLiteralSliceNormalized(this.literal);

  @override
  Parser<MutableStringSlice, MutableStringSlice> body() {
    return OneOfLazy([
      () => StringLiteralSlice(unorm.nfc(literal)),
      () => StringLiteralSlice(unorm.nfd(literal)),
      () => StringLiteralSlice(unorm.nfkc(literal)),
      () => StringLiteralSlice(unorm.nfkd(literal)),
    ]);
  }
}
