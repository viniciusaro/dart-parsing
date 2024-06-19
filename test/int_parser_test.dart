import 'package:parsing/src/parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string parser", () {
    expect(IntParser().run("42"), (42, ""));
  });
}
