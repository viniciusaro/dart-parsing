part of '../parsing.dart';

final class StringLiteral with Parser<MutableStringSlice, MutableStringSlice> {
  final String literal;
  final MutableStringSlice literalSlice;

  StringLiteral(this.literal) : this.literalSlice = MutableStringSlice(literal);

  @override
  (MutableStringSlice, MutableStringSlice) run(MutableStringSlice input) {
    if (input.startsWith(literalSlice)) {
      final result = literalSlice;
      input.skip(literalSlice.length);
      return (result, input);
    }
    throw ParserError(
      expected: literal,
      remainingInput: input,
    );
  }
}

// final class StringThrough with Parser<MutableStringSlice, MutableStringSlice> {
//   final MutableStringSlice literal;

//   StringThrough(String literal) : this.literal = literal.slice;

//   @override
//   (MutableStringSlice, MutableStringSlice) run(MutableStringSlice input) {
//     int literalIndex = 0;

//     for (int inputIndex = 0; inputIndex < input.length; inputIndex++) {
//       if (input.iterable.elementAt(inputIndex) ==
//           literal.iterable.elementAt(literalIndex)) {
//         literalIndex++;
//       }
//       if (literalIndex == literal.length) {
//         final result = input.prefix(inputIndex + 1);
//         final rest = input.removeFirst(inputIndex + 1);
//         return (result, rest);
//       }
//     }
//     throw ParserError(
//       expected: input.toString(),
//       remainingInput: input.toString(),
//     );
//   }
// }

class StringLiteralNormalized
    with Parser<MutableStringSlice, MutableStringSlice> {
  final String literal;

  StringLiteralNormalized(this.literal);

  @override
  Parser<MutableStringSlice, MutableStringSlice> body() {
    return OneOfLazy([
      () => StringLiteral(unorm.nfc(literal)),
      () => StringLiteral(unorm.nfd(literal)),
      () => StringLiteral(unorm.nfkc(literal)),
      () => StringLiteral(unorm.nfkd(literal)),
    ]);
  }
}
