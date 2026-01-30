import 'package:parsing/parsing.dart';

import 'int_slice.dart';
import 'slices.dart';
import 'string_slice.dart';

final class DoubleParserSlice with Parser<double, MutableStringSlice> {
  @override
  Parser<double, MutableStringSlice> body() {
    final dotOrComma = OneOf([
      StringLiteralSlice(","),
      StringLiteralSlice("."),
    ]);

    final parseDoubleFromTuple = ((int, int?) tuple) {
      return tuple.$2 != null
          ? double.parse("${tuple.$1}.${tuple.$2}")
          : tuple.$1.toDouble();
    };

    return IntParserSlice()
        .skip(OptionalParser(dotOrComma))
        .take(OptionalParser(IntParserSlice()))
        .map(parseDoubleFromTuple);
  }
}
