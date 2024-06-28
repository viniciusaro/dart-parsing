import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string literal", () {
    final (result, rest) = StringLiteral("Brasília").run(
      "Brasília/DF".codeUnits.collection,
    );
    expect(result, "Brasília");
    expect(rest, "/DF");
  });
}
