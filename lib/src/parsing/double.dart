part of 'parsing.dart';

class DoubleParser with Parser<IterableCollection<int>, double> {
  @override
  Parser<IterableCollection<int>, double> body() {
    final dotOrComma = OneOf([
      StringLiteral(","),
      StringLiteral("."),
    ]);

    final parseDoubleFromTuple = ((int, int?) tuple) {
      return tuple.$2 != null
          ? double.parse("${tuple.$1}.${tuple.$2}")
          : tuple.$1.toDouble();
    };

    return IntParser()
        .skip(OptionalParser(dotOrComma))
        .take(OptionalParser(IntParser()))
        .map(parseDoubleFromTuple);
  }
}
