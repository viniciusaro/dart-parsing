import 'package:parsing/parsing.dart';

import 'int_code_unit.dart';
import 'string_code_unit.dart';

final class DoubleParserCodeUnit with Parser<double, Iterable<int>> {
  @override
  Parser<double, Iterable<int>> body() {
    final dotOrComma = OneOf([
      StringLiteralCodeUnit(","),
      StringLiteralCodeUnit("."),
    ]);

    final parseDoubleFromTuple = ((int, int?) tuple) {
      return tuple.$2 != null
          ? double.parse("${tuple.$1}.${tuple.$2}")
          : tuple.$1.toDouble();
    };

    return IntParserCodeUnit()
        .skip(OptionalParser(dotOrComma))
        .take(OptionalParser(IntParserCodeUnit()))
        .map(parseDoubleFromTuple);
  }
}
