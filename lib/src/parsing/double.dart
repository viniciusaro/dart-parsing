part of 'parsing.dart';

class DoubleParser with Parser<IterableCollection<int>, double> {
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

    return IntParser()
        .take(OptionalParser(IterableCollectionPrefix(isDotOrComma)))
        .take(OptionalParser(IntParser()))
        .map(parseDoubleFromTuple);
  }
}
