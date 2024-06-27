import 'package:parsing/parsing.dart';

class DoubleParserRegex with Parser<String, double> {
  @override
  Parser<String, double> body() {
    return StringPrefix.pattern(r'\d+([,|.]\d*)?')
        .map((string) => string.replaceAll(",", "."))
        .map(double.parse);
  }
}
