import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:parsing/parsing.dart';

class OperationBenchmark extends BenchmarkBase {
  final void Function() operation;
  final void Function()? tearDown;

  OperationBenchmark(String name, this.operation, {this.tearDown})
      : super("Operation - $name");

  @override
  void run() {
    operation();
    super.run();
  }

  @override
  void teardown() {
    if (tearDown != null) {
      print("Done: \n");
      tearDown!.call();
    }
  }
}

class ParserBenchmark<A, Input> extends BenchmarkBase {
  final Parser<A, Input> Function() parserBuilder;
  final ParserBenchmarkData<A, Input> Function() subjectBuilder;

  late Parser<A, Input> parser;

  ParserBenchmark(String? name, this.parserBuilder, this.subjectBuilder)
      : super(name ?? parserBuilder().runtimeType.toString());

  @override
  void setup() {
    parser = parserBuilder();
    super.setup();
  }

  @override
  void run() {
    final subject = subjectBuilder();
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
    required Input Function() input,
    A? result,
  }) {
    return ParserBenchmark(
      name,
      () => this,
      () => ParserBenchmarkData(input: input(), result: result),
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
      bench.report();
    }
  }
}
