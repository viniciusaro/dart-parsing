part of 'parsing.dart';

class DoubleParser with Parser<String, double> {
  @override
  Parser<String, double> body() {
    return StringPrefix.pattern(r'\d+([,|.]\d*)?')
        .map((string) => string.replaceAll(",", "."))
        .map(double.parse);
  }
}

class DoubleParserCodeUnitsPrefix with Parser<IterableCollection<int>, double> {
  @override
  Parser<IterableCollection<int>, double> body() {
    final isDotOrComma = (int e) {
      return e == ".".codeUnits.first || e == ",".codeUnits.first;
    };

    final parseDoubleFromTuple = ((int, dynamic, int?) tuple) {
      return tuple.$3 != null
          ? double.parse("${tuple.$1}.${tuple.$3}")
          : tuple.$1.toDouble();
    };

    return IntParserCodeUnitsPrefix()
        .take(OptionalParser(IterableCollectionPrefix(isDotOrComma)))
        .take(OptionalParser(IntParserCodeUnitsPrefix()))
        .map(parseDoubleFromTuple);
  }
}
