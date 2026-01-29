import 'package:benchmarking/benchmarks/benchmark_coordinate.dart';
import 'package:benchmarking/example/example.dart';
import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

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
    final (result, rest) = races.run(coordsBenchmarkInput.slice);
    expect(result.races.length, 2);
    expect(result.races.elementAt(0), bsbRace);
    expect(result.races.elementAt(1), nyRace);
    expect(rest.toString(), "");
  });
}
