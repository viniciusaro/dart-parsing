import 'package:parsing/fp.dart';
import 'package:parsing/parsing.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

final class StringLiteralCodeUnit with Parser<Iterable<int>, Iterable<int>> {
  final String literal;
  final Iterable<int> codeUnits;

  StringLiteralCodeUnit(this.literal) : this.codeUnits = literal.codeUnits;

  @override
  (Iterable<int>, Iterable<int>) run(Iterable<int> input) {
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

class StringLiteralCodeUnitNormalized
    with Parser<Iterable<int>, Iterable<int>> {
  final String literal;

  StringLiteralCodeUnitNormalized(this.literal);

  @override
  Parser<Iterable<int>, Iterable<int>> body() {
    return OneOfLazy([
      () => StringLiteralCodeUnit(unorm.nfc(literal)),
      () => StringLiteralCodeUnit(unorm.nfd(literal)),
      () => StringLiteralCodeUnit(unorm.nfkc(literal)),
      () => StringLiteralCodeUnit(unorm.nfkd(literal)),
    ]);
  }
}
