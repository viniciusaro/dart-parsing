import 'package:benchmarking/example/example.dart';
import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

final _coord = """
Brasília,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
New York,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W,
15.832373° S, 47.987751° W""";

final racesInput = List.generate(1000, (_) => _coord).join(",\n");

final bsbRace = Race(City.bsb, [
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
]);

void main() {
  test("races parser", () {
    final (result, rest) = races.run(racesInput.codeUnits.collection);
    expect(result.races.first, bsbRace);
    expect(rest.source, "".codeUnits);
  });

  test("races string parser", () {
    final (result, rest) = racesString.run(racesInput.collection);
    expect(result.races.first, bsbRace);
    expect(rest.source, "".codeUnits);
  });
}
