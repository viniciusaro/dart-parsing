import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:parsing/parsing.dart';

class BenchmarkIntParserStringInput extends BenchmarkBase {
  late IntParser parser;

  BenchmarkIntParserStringInput() : super("IntParserStringInput");

  @override
  void setup() {
    parser = IntParser();
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run("1234567891234567891");
    assert(result == 1234567891234567891);
    assert(rest == "");
  }
}

class BenchmarkIntParserCodeUnitsInput extends BenchmarkBase {
  late IntParserCodeUnits parser;
  late Iterable<int> codeUnits;

  BenchmarkIntParserCodeUnitsInput() : super("IntParserCodeUnitsInput");

  @override
  void setup() {
    parser = IntParserCodeUnits();
    codeUnits = "1234567891234567891".codeUnits;
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(codeUnits);
    assert(result == 1234567891234567891);
    assert(rest.isEmpty);
  }
}
