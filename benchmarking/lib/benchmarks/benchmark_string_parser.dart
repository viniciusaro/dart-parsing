import 'package:benchmarking/parsers.dart';
import 'package:parsing/parsing.dart';

final stringPrefix = BenchmarkSuite("String parsers, prefix", () {
  final string = "Brasília/DF";

  return [
    StringStartsWith("Brasília").bench(
      input: string,
      result: "Brasília",
    ),
    StringStartsWith(RegExp(r"Brasília")).bench(
      name: "StringStartsWithPattern",
      input: string,
      result: "Brasília",
    ),
    StringPrefix.literal("Brasília").bench(
      name: "StringPrefixLiteral",
      input: string,
      result: "Brasília",
    ),
    StringPrefix.pattern("Brasília").bench(
      name: "StringPrefixPattern",
      input: string,
      result: "Brasília",
    ),
  ];
});
