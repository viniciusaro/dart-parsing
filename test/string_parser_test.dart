import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string literal", () {
    final (result, rest) = StringLiteral("Brasília").run(
      "Brasília/DF".codeUnits.collection,
    );
    expect(result, "Brasília");
    expect(rest.source, "/DF".codeUnits);
  });

  test("string literal acute", () {
    final eAcute0 = "é"; // String.fromCharCodes([0x00E9]);
    final eAcute1 = "é"; // String.fromCharCodes([0x0065, 0x0301]);

    final (result, rest) = StringLiteralNormalized(eAcute0).run(
      eAcute1.codeUnits.collection,
    );
    expect(result, eAcute1);
    expect(rest.source, []);
  });

  test("string through", () {
    final input = "Lorem ipsum\nEnd";
    final (result, rest) = StringThrough("\n").run(input.codeUnits.collection);
    expect(result.source, "Lorem ipsum\n".codeUnits);
    expect(rest.source, "End".codeUnits);
  });
}
