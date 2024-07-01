import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("many returns all values that match, when there are many", () {
    final input = "BSB, BSB, BSB";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb, City.bsb, City.bsb]);
    expect(rest.stringValue, "");
  });

  test("many returns single value when there is only one", () {
    final input = "BSB";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb]);
    expect(rest.stringValue, "");
  });

  test("many returns empty on empty input", () {
    final input = "";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, []);
    expect(rest.stringValue, "");
  });

  test("many returns rest of string after consming all matches", () {
    final input = "BSB, NY, AMS, ";
    final parser = Many(city, separator: StringLiteral(", "));
    final (result, rest) = parser.run(input.codeUnits.collection);

    expect(result, [City.bsb, City.ny, City.ams]);
    expect(rest.stringValue, ", ");
  });
}
