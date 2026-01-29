import 'package:benchmarking/parsers.dart';
import 'package:parsing/parsing.dart';

final intMaxIntSuite = BenchmarkSuite("Int parsers, max int", () {
  final string = "1234567891234567891";
  const intResult = 1234567891234567891;

  return [
    IntParser().bench(
      input: () => MutableStringSlice(string),
      result: intResult,
    ),
  ];
});

final intLongSuffixSuite = BenchmarkSuite("Int parsers, long suffix", () {
  final suffix = List.generate(100000, (_) => lipsum).join("\n");
  final string = "1234567891234567891$suffix";
  const intResult = 1234567891234567891;

  return [
    IntParser().bench(
      input: () => MutableStringSlice(string),
      result: intResult,
    ),
  ];
});
