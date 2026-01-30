import 'package:benchmarking/benchmarks/benchmark_coordinate.dart';
import 'package:benchmarking/example/example.dart';
import 'package:parsing/extra.dart';
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
  test("city parser", () {
    final (result, rest) = city.run("Brasília".codeUnits);
    expect(result, City.bsb);
    expect(rest, "".codeUnits);
  });

  test("city slice parser", () {
    final (result, rest) = citySlice.run(MutableStringSlice("Brasília"));
    expect(result, City.bsb);
    expect(rest.toString(), "");
  });

  test("races parser", () {
    final (result, rest) = races.run(coordsBenchmarkInput.codeUnits);
    expect(result.races.length, 2);
    expect(result.races.elementAt(0), bsbRace);
    expect(result.races.elementAt(1), nyRace);
    expect(rest, "".codeUnits);
  });

  test("races slices parser", () {
    final (result, rest) = racesSlice.run(
      MutableStringSlice(coordsBenchmarkInput),
    );
    expect(result.races.length, 2);
    expect(result.races.elementAt(0), bsbRace);
    expect(result.races.elementAt(1), nyRace);
    expect(rest.toString(), "");
  });
}
