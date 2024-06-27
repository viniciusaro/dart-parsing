import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("single integer", () {
    final (result, rest) = IntParser().run("42".codeUnits.collection);
    expect(result, 42);
    expect(rest.source, []);
  });

  test("integer and some value", () {
    final (result, rest) = IntParser().run("42A".codeUnits.collection);
    expect(result, 42);
    expect(rest.source, "A".codeUnits);
  });

  test("some value and an integer", () {
    expect(
      () => IntParser().run("A42".codeUnits.collection),
      throwsA(isA<ParserError>()),
    );
  });
}
