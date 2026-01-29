import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("single integer", () {
    final (result, rest) = IntParser().run(MutableStringSlice("42"));
    expect(result, 42);
    expect(rest.toString(), "");
  });

  test("integer and some value", () {
    final (result, rest) = IntParser().run(MutableStringSlice("42A"));
    expect(result, 42);
    expect(rest.toString(), "A");
  });

  test("integer and dot", () {
    final (result, rest) = IntParser().run(MutableStringSlice("42.0"));
    expect(result, 42);
    expect(rest.toString(), ".0");
  });

  test("integer and comma", () {
    final (result, rest) = IntParser().run(MutableStringSlice("42,0"));
    expect(result, 42);
    expect(rest.toString(), ",0");
  });

  test("some value and an integer", () {
    expect(
      () => IntParser().run(MutableStringSlice("A42")),
      throwsA(isA<ParserError>()),
    );
  });
}
