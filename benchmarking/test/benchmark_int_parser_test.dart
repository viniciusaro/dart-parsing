import 'dart:convert';

import 'package:benchmarking/parsers.dart';
import 'package:benchmarking/parsers/int.dart';
import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string prefix parser", () {
    expect(IntParserStringPrefix().run("42"), (42, ""));
  });

  test("int string collection parser", () {
    final (result0, rest0) = IntParserString().run("42".slice);
    expect(result0, 42);
    expect(rest0, "".slice);

    final (result1, rest1) = IntParserString().run("42A".slice);
    expect(result1, 42);
    expect(String.fromCharCodes(rest1.iterable), "A");
    expect(rest1, "A".slice);
    expect(rest1.length, 1);

    final (result2, rest2) = IntParserString().run("15.0".slice);
    expect(result2, 15);
    expect(String.fromCharCodes(rest2.iterable), ".0");
    expect(rest2, ".0".slice);
    expect(rest2.length, 2);
  });

  test("double string collection parser", () {
    final (result0, rest0) = DoubleParserString().run("42.0".slice);
    expect(result0, 42.0);
    expect(rest0, "".slice);
  });

  test("runes prefix parser", () {
    final (result, rest) = IntParserRunesPrefix().run(
      IterableCollection("42".runes),
    );
    expect(result, 42);
    expect(rest.iterable, []);
  });

  test("bytes prefix parser", () {
    final (result, rest) = IntParserBytesPrefix().run(
      IterableCollection(utf8.encode("42")),
    );
    expect(result, 42);
    expect(rest.iterable, []);
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
