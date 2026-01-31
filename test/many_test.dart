import 'package:dart_parsing/dart_parsing.dart';
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
  test("many returns all values that match, when there are many", () {
    final input = "BSB, BSB, BSB";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits);

    expect(result, [City.bsb, City.bsb, City.bsb]);
    expect(rest, "".codeUnits);
  });

  test("many returns single value when there is only one", () {
    final input = "BSB";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits);

    expect(result, [City.bsb]);
    expect(rest, "".codeUnits);
  });

  test("many returns empty on empty input", () {
    final input = "";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits);

    expect(result, []);
    expect(rest, "".codeUnits);
  });

  test("many returns rest of string after consming all matches", () {
    final input = "BSB, NY, AMS, ";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits);

    expect(result, [City.bsb, City.ny, City.ams]);
    expect(rest, ", ".codeUnits);
  });
}
