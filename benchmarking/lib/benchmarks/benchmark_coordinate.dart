import 'package:benchmarking/example/example.dart';
import 'package:benchmarking/parsers.dart';
import 'package:parsing/parsing.dart';

final coordsBenchmarkInput = """
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
    final escalation = 10000;

    return [
      races.bench(
        name: "int - StringSlice on $escalation",
        input: () => MutableStringSlice(
          List.generate(escalation, (_) => coordsBenchmarkInput).join("\n"),
        ),
      ),
    ];
  },
);
