import 'package:benchmarking/parsers.dart';
import 'package:parsing/parsing.dart';

final doubleMaxDoubleSuite = BenchmarkSuite("Double parsers, max double", () {
  final string = "1234567891234567891.1";
  const doubleResult = 1234567891234567891.1;

  return [
    DoubleParser().bench(
      input: string.codeUnits.collection,
      result: doubleResult,
    ),
  ];
});

final doubleLongSuffixSuite = BenchmarkSuite("Double parsers, long suffix", () {
  final suffix = List.generate(100000, (_) => lipsum).join("\n");
  final string = "1234567891234567891.1$suffix";
  const doubleResult = 1234567891234567891.1;

  return [
    DoubleParser().bench(
      input: string.codeUnits.collection,
      result: doubleResult,
    ),
  ];
});
