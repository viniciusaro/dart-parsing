import 'package:benchmarking/parsers.dart';

final stringOperationsSuite = BenchmarkSuite("String operations", () {
  final suffix = List.generate(10000, (_) => lipsum).join("\n");
  final prefix = "Brasília/DF";
  final string = "$prefix$suffix";

  return [
    OperationBenchmark(
      "Substring small string",
      () => prefix.substring(8),
    ),
    OperationBenchmark(
      "Substring big string",
      () => string.substring(8),
    ),
    OperationBenchmark(
      "Runes small string",
      () => prefix.runes,
    ),
    OperationBenchmark(
      "Runes big string",
      () => string.runes,
    ),
    OperationBenchmark(
      "Code Units small string",
      () => prefix.codeUnits,
    ),
    OperationBenchmark(
      "Code Units big string",
      () => string.codeUnits,
    ),
    OperationBenchmark(
      "Create String from few Units",
      () => String.fromCharCodes(prefix.codeUnits),
    ),
    OperationBenchmark(
      "Create String from many Units",
      () => String.fromCharCodes(string.codeUnits),
    ),
  ];
});
