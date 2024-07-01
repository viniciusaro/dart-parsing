import 'dart:convert';

import 'package:benchmarking/parsers.dart';
import 'package:benchmarking/parsers/int.dart';
import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string prefix parser", () {
    expect(IntParserStringPrefix().run("42"), (42, ""));
  });

  test("string collection parser", () {
    final (result0, rest0) = IntParserString().run("42".collection);
    expect(result0, 42);
    expect(rest0, "".collection);

    final (result1, rest1) = IntParserString().run("42A".collection);
    expect(result1, 42);
    expect(String.fromCharCodes(rest1.source), "A");
    expect(rest1, "A".collection);
    expect(rest1.length, 1);
  });

  test("runes prefix parser", () {
    final (result, rest) = IntParserRunesPrefix().run(
      IterableCollection("42".runes),
    );
    expect(result, 42);
    expect(rest.source, []);
  });

  test("bytes prefix parser", () {
    final (result, rest) = IntParserBytesPrefix().run(
      IterableCollection(utf8.encode("42")),
    );
    expect(result, 42);
    expect(rest.source, []);
  });

  test("regex parser", () {
    expect(IntParserRegex().run("42"), (42, ""));
    expect(IntParserRegex().run("42A"), (42, "A"));
  });

  test("code units parser", () {
    final (result, rest) = IntParserCodeUnits().run("42".codeUnits.collection);
    expect(result, 42);
    expect(rest, []);
  });
}
