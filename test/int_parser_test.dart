import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("single integer", () {
    final (result, rest) = IntParser().run("42".slice);
    expect(result, 42);
    expect(rest.toString(), "");
  });

  test("integer and some value", () {
    final (result, rest) = IntParser().run("42A".slice);
    expect(result, 42);
    expect(rest.toString(), "A");
  });

  test("integer and dot", () {
    final (result, rest) = IntParser().run("42.0".slice);
    expect(result, 42);
    expect(rest.toString(), ".0");
  });

  test("integer and comma", () {
    final (result, rest) = IntParser().run("42,0".slice);
    expect(result, 42);
    expect(rest.toString(), ",0");
  });

  test("some value and an integer", () {
    expect(
      () => IntParser().run("A42".slice),
      throwsA(isA<ParserError>()),
    );
  });
}
