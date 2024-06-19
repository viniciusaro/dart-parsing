import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("int", () {
    final (result, rest) = IntParser().run("42");
    expect(result, 42);
    expect(rest, "");
  });
}
