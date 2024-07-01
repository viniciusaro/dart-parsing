import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

enum City {
  bsb,
  ny,
  ams,
}

final city = OneOf([
  StringLiteral("BSB").map((_) => City.bsb),
  StringLiteral("NY").map((_) => City.ny),
  StringLiteral("AMS").map((_) => City.ams),
]);

void main() {
  test("returns all values that match, when there are many", () {
    final input = "BSB, BSB, BSB";
    final parser = OneOrMore(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb, City.bsb, City.bsb]);
    expect(rest.stringValue, "");
  });

  test("many returns single value when there is only one", () {
    final input = "BSB";
    final parser = OneOrMore(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb]);
    expect(rest.stringValue, "");
  });

  test("throws on empty input", () {
    final input = "";
    final parser = OneOrMore(city, separator: StringLiteral(", "));
    expect(
      () => parser.run(input.codeUnits.collection),
      throwsA(isA<ParserError>()),
    );
  });

  test("returns rest of string after consming all matches", () {
    final input = "BSB, NY, AMS, ";
    final parser = OneOrMore(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb, City.ny, City.ams]);
    expect(rest.stringValue, ", ");
  });
}
