import 'dart:convert';

import 'package:benchmarking/parsers.dart';
import 'package:benchmarking/parsers/int.dart';
import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string prefix parser", () {
    expect(IntParserStringPrefix().run("42"), (42, ""));
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

  // test("starts with parser", () {
  //   expect(IntParserStringStartsWith().run("42"), (42, ""));
  //   expect(IntParserStringStartsWith().run("42A"), (42, "A"));
  // });

  test("code units parser", () {
    final (result, rest) = IntParserCodeUnits().run("42".codeUnits);
    expect(result, 42);
    expect(rest, []);
  });
}
