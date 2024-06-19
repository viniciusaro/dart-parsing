part of 'parsing.dart';

class DoubleParser with Parser<String, double> {
  DoubleParser();

  @override
  (double, String) run(String input) {
    return StringPrefix(r'\d+[,|.]?\d*')
        .map((string) => string.replaceAll(",", "."))
        .map(double.parse)
        .run(input);
  }
}
