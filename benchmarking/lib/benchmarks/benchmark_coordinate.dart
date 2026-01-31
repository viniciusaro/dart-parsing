import 'package:benchmarking/example/example.dart';
import 'package:benchmarking/parsers.dart';
import 'package:dart_parsing/extra.dart';
import 'package:dart_parsing/dart_parsing.dart';
import 'package:petitparser/petitparser.dart' as petit;

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
    final escalation = 10000000;
    final input =
        List.generate(escalation, (_) => coordBenchmarkInput).join("\n");
    print("input length: ${input.length}");
    print("input size: ${input.codeUnits.length * 2} bytes");

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
      BenchmarkPetitParser().bench(
        name: "petit parser on $escalation",
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

final class BenchmarkPetitParser with Parser<Coordinate, String> {
  // Number like 15 or 15.832373
  final number = (petit.digit().plus() &
          (petit.char('.') & petit.digit().plus()).optional())
      .flatten()
      .trim()
      .map(double.parse);

  // Degree symbol
  final degree = petit.char('°').trim();

  // Direction letters
  final northSouth = (petit.char('N') | petit.char('S'))
      .trim()
      .map((value) => value == 'S' ? -1 : 1);

  final eastWest = (petit.char('E') | petit.char('W'))
      .trim()
      .map((value) => value == 'W' ? -1 : 1);

  @override
  (Coordinate, String) run(String input) {
    final latitude =
        (number & degree & northSouth).map((values) => values[0] * values[2]);

    final longitude =
        (number & degree & eastWest).map((values) => values[0] * values[2]);

    final coordinate = (latitude & petit.char(',').trim() & longitude)
        .map((values) => Coordinate(values[0], values[2]));

    final result = coordinate.parse(input);
    final rest = result.buffer.substring(result.position);

    switch (result) {
      case petit.Success<Coordinate>():
        final coordinateResult = result.value;
        return (coordinateResult, rest);
      case petit.Failure():
        throw ParserError(
          expected: "Coordinate",
          remainingInput: rest,
        );
    }
  }
}
