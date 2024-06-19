part of 'parsing.dart';

class DoubleParser with Parser<String, double> {
  DoubleParser();

  @override
  Parser<String, double> body() {
    return StringPrefix(r'\d+([,|.]\d*)?')
        .map((string) => string.replaceAll(",", "."))
        .map(double.parse);
  }
}
