import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("string literal", () {
    final (result, rest) = StringLiteral("Brasília").run(
      MutableStringSlice("Brasília/DF"),
    );
    expect(result.toString(), "Brasília");
    expect(rest.toString(), "/DF");
  });

  test("string literal acute", () {
    final eAcute0 = "é"; // String.fromCharCodes([0x00E9]);
    final eAcute1 = "é"; // String.fromCharCodes([0x0065, 0x0301]);

    final (result, rest) = StringLiteralNormalized(eAcute0).run(
      MutableStringSlice(eAcute1),
    );
    expect(result.toString(), eAcute1);
    expect(rest.toString(), "");
  });

  test("string through", () {
    final input = "Lorem ipsum\nEnd";
    final (result, rest) = StringThrough("\n").run(MutableStringSlice(input));
    expect(result.toString(), "Lorem ipsum\n");
    expect(rest.toString(), "End");
  });

  test(
      "acute strings are not automatically made equivalent by parsers, "
      "since dart string representation does not consider different "
      "enconded chars to be equal ", () {
    const bsb = "BSB";
    const iAcute0 = "í"; // String.fromCharCodes([0x00ED]);
    const iAcute1 = "í"; // String.fromCharCodes([0x0069, 0x0301]);

    final input = [
      "Bras${iAcute0}lia",
      "Bras${iAcute1}lia",
    ];

    final cityParser = OptionalParser(
      OneOf([StringLiteral("Bras${iAcute0}lia").map((_) => bsb)]),
    );

    final result = input
        .map((city) => cityParser.run(MutableStringSlice(city)))
        .map((tuple) => tuple.$1)
        .toList();

    expect(result, [bsb, null]);
  });
}
