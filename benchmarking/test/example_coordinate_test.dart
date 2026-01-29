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

final bsbRace = Race(City.bsb, [
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
  Coordinate(-15.832373, -47.987751),
]);

final nyRace = Race(City.ny, [
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
    final (result, rest) = races.run(_coord.slice);
    expect(result.races.length, 2);
    expect(result.races.elementAt(0), bsbRace);
    expect(result.races.elementAt(1), nyRace);
    expect(rest.toString(), "");
  });
}
