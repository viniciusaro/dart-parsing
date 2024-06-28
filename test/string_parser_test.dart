import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string literal", () {
    final (result, rest) = StringPrefix.literal("Brasília").run("Brasília/DF");
    expect(result, "Brasília");
    expect(rest, "/DF");
  });

  test("string pattern", () {
    final (result, rest) = StringPrefix.pattern("Brasília").run("Brasília/DF");
    expect(result, "Brasília");
    expect(rest, "/DF");
  });
}
