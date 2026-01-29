import 'package:parsing/src/parsing/extra.dart';
import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("single integer", () {
    final (result, rest) = IntParserCodeUnit().run("42".codeUnits);
    expect(result, 42);
    expect(rest, "".codeUnits);
  });

  test("integer and some value", () {
    final (result, rest) = IntParserCodeUnit().run("42A".codeUnits);
    expect(result, 42);
    expect(rest, "A".codeUnits);
  });

  test("integer and dot", () {
    final (result, rest) = IntParserCodeUnit().run("42.0".codeUnits);
    expect(result, 42);
    expect(rest, ".0".codeUnits);
  });

  test("integer and comma", () {
    final (result, rest) = IntParserCodeUnit().run("42,0".codeUnits);
    expect(result, 42);
    expect(rest, ",0".codeUnits);
  });

  test("some value and an integer", () {
    expect(
      () => IntParserCodeUnit().run("A42".codeUnits),
      throwsA(isA<ParserError>()),
    );
  });
}
