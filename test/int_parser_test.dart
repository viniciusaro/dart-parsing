import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("single integer", () {
    final (result, rest) = IntParser().run("42".slice);
    expect(result, 42);
    expect(rest.iterable, []);
  });

  test("integer and some value", () {
    final (result, rest) = IntParser().run("42A".slice);
    expect(result, 42);
    expect(rest.iterable, "A".codeUnits);
  });

  test("some value and an integer", () {
    expect(
      () => IntParser().run("A42".slice),
      throwsA(isA<ParserError>()),
    );
  });
}
