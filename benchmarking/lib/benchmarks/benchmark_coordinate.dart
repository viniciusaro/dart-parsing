import 'package:benchmarking/example/example.dart';
import 'package:benchmarking/parsers.dart';
import 'package:parsing/extra.dart';
import 'package:parsing/parsing.dart';

final coordBenchmarkInput = "15.832373° S, 47.987751° W";

final raceCoordsBenchmarkInput = """
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

final racesCoordCollectionsSuite = BenchmarkSuite(
  "Races coord parser",
  () {
    final escalation = 100000;

    return [
      races.bench(
        name: "code unit on $escalation",
        input: () => List.generate(escalation, (_) => raceCoordsBenchmarkInput)
            .join("\n")
            .codeUnits,
      ),
      racesSlice.bench(
        name: "MutableStringSlice on $escalation",
        input: () => MutableStringSlice(
          List.generate(escalation, (_) => raceCoordsBenchmarkInput).join("\n"),
        ),
      ),
    ];
  },
);

final coordCollectionsSuite = BenchmarkSuite(
  "Coord parser",
  () {
    final escalation = 100000;
    final input =
        List.generate(escalation, (_) => coordBenchmarkInput).join("\n");
    print("input size: ${input.length}");

    return [
      coord.bench(
        name: "code unit on $escalation",
        input: () => List.generate(escalation, (_) => coordBenchmarkInput)
            .join("\n")
            .codeUnits,
      ),
      coordSlice.bench(
        name: "MutableStringSlice on $escalation",
        input: () => MutableStringSlice(
          List.generate(escalation, (_) => coordBenchmarkInput).join("\n"),
        ),
      ),
      BenchmarkCoordinateRegexParser().bench(
        name: "regex on $escalation",
        input: () =>
            List.generate(escalation, (_) => coordBenchmarkInput).join("\n"),
      ),
    ];
  },
);

class BenchmarkCoordinateRegexParser with Parser<Coordinate, String> {
  @override
  (Coordinate, String) run(String input) {
    return parseOneCoordinateWithRegex(input);
  }

  final coordinatePrefixRegex = RegExp(
    r'^\s*'
    r'(\d+(?:\.\d+)?)°\s*([NS])'
    r'\s*,\s*'
    r'(\d+(?:\.\d+)?)°\s*([EW])'
    r'\s*(?:\n|$)',
  );

  (Coordinate, String) parseOneCoordinateWithRegex(String input) {
    final match = coordinatePrefixRegex.firstMatch(input)!;

    final latValue = double.parse(match.group(1)!);
    final latDir = match.group(2)!;
    final lngValue = double.parse(match.group(3)!);
    final lngDir = match.group(4)!;

    final lat = latDir == 'S' ? -latValue : latValue;
    final lng = lngDir == 'W' ? -lngValue : lngValue;

    final coordinate = Coordinate(lat, lng);
    final rest = input.substring(match.end);

    return (coordinate, rest);
  }
}
