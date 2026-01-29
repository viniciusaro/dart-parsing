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

final coordCollectionsSuite = BenchmarkSuite(
  "Coord parser",
  () {
    return [
      races.bench(
        name: "Int - StringSlice on 1000",
        input: List.generate(1000, (_) => _coord).join(",\n").slice,
      ),
      races.bench(
        name: "Int - StringSlice on 10000",
        input: List.generate(10000, (_) => _coord).join(",\n").slice,
      ),
    ];
  },
);
