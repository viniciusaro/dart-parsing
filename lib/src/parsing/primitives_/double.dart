import 'parser.dart';
import 'string.dart';

final class DoubleParser with Parser<double, StringSlice> {
  // @override
  // Parser<double, StringSlice> body() {
  // final dotOrComma = OneOf([
  //   StringLiteral(","),
  //   StringLiteral("."),
  // ]);

  // final parseDoubleFromTuple = ((int, int?) tuple) {
  //   return tuple.$2 != null
  //       ? double.parse("${tuple.$1}.${tuple.$2}")
  //       : tuple.$1.toDouble();
  // };

  // return IntParser()
  //     .skip(OptionalParser(dotOrComma))
  //     .take(OptionalParser(IntParser()))
  //     .map(parseDoubleFromTuple);
  // }
}
