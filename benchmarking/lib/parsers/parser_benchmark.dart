import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:parsing/parsing.dart';

class OperationBenchmark extends BenchmarkBase {
  final void Function() operation;

  OperationBenchmark(String name, this.operation) : super("Operation - $name");

  @override
  void run() {
    operation();
    super.run();
  }
}

class ParserBenchmark<A, Input> extends BenchmarkBase {
  final Parser<A, Input> Function() parserBuilder;
  final ParserBenchmarkData<A, Input> Function() subjectBuilder;

  late Parser<A, Input> parser;
  late ParserBenchmarkData<A, Input> subject;

  ParserBenchmark(String? name, this.parserBuilder, this.subjectBuilder)
      : super(name ?? parserBuilder().runtimeType.toString());

  @override
  void setup() {
    parser = parserBuilder();
    subject = subjectBuilder();
    super.setup();
  }

  @override
  void run() {
    final (result, _) = parser.run(subject.input);
    if (subject.result != null) {
      assert(result == subject.result);
    }
  }
}

class ParserBenchmarkData<A, Input> {
  final Input input;
  final A? result;

  ParserBenchmarkData({required this.input, required this.result});
}

extension ParserBenchmarking<A, Input> on Parser<A, Input> {
  ParserBenchmark<A, Input> bench({
    String? name,
    required Input input,
    A? result,
  }) {
    return ParserBenchmark(
      name,
      () => this,
      () => ParserBenchmarkData(input: input, result: result),
    );
  }
}

class BenchmarkSuite extends BenchmarkBase {
  final List<BenchmarkBase> Function() benchmarks;

  BenchmarkSuite(super.name, this.benchmarks);

  @override
  void report() {
    print("\nRunning suite: $name");
    print("-------------");

    final benchmarks = this.benchmarks();

    for (var bench in benchmarks) {
      print("Running: ${bench.name}");
      bench.report();
    }
  }
}
