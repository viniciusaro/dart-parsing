import 'dart:convert';

import 'package:benchmarking/parser_benchmark.dart';
import 'package:benchmarking/parser_benchmark_helpers.dart';
import 'package:benchmarking/parsers.dart';

import 'package:parsing/parsing.dart';

final intMaxIntSuite = BenchmarkSuite("Int parsers, max int", () {
  final string = "1234567891234567891";
  const intResult = 1234567891234567891;

  return [
    IntParser().bench(
      input: string.codeUnits.collection,
      result: intResult,
    ),
    IntParserRegex().bench(
      input: string,
      result: intResult,
    ),
    IntParserStringPrefix().bench(
      input: string,
      result: intResult,
    ),
    IntParserCodeUnits().bench(
      input: string.codeUnits,
      result: intResult,
    ),
    IntParserRunesPrefix().bench(
      input: string.runes.collection,
      result: intResult,
    ),
    IntParserBytesPrefix().bench(
      input: utf8.encode(string).collection,
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
      input: string.codeUnits.collection,
      result: intResult,
    ),
    IntParserRegex().bench(
      input: string,
      result: intResult,
    ),
    IntParserStringPrefix().bench(
      input: string,
      result: intResult,
    ),
    IntParserCodeUnits().bench(
      input: string.codeUnits,
      result: intResult,
    ),
    IntParserRunesPrefix().bench(
      input: string.runes.collection,
      result: intResult,
    ),
    IntParserBytesPrefix().bench(
      input: utf8.encode(string).collection,
      result: intResult,
    ),
  ];
});
