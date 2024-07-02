import 'package:benchmarking/example/example.dart';
import 'package:benchmarking/parsers.dart';
import 'package:parsing/parsing.dart';

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

final racesInput = List.generate(10000, (_) => _coord).join(",\n");

final coordCollectionsSuite = BenchmarkSuite(
  "Coord parser - int vs string collections",
  () {
    return [
      races.bench(
        name: "IntCollection",
        input: racesInput.codeUnits.collection,
      ),
      racesString.bench(
        name: "StringCollection",
        input: racesInput.collection,
      ),
    ];
  },
);
