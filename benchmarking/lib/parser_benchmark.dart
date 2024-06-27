import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:collection/collection.dart';
import 'package:parsing/parsing.dart';

class ParserBenchmark<Input, A> extends BenchmarkBase {
  final Parser<Input, A> Function() parserBuilder;
  final ParserBenchmarkData<Input, A> Function() subjectBuilder;

  late Parser<Input, A> parser;
  late ParserBenchmarkData<Input, A> subject;

  ParserBenchmark(this.parserBuilder, this.subjectBuilder)
      : super(parserBuilder().runtimeType.toString());

  @override
  void setup() {
    parser = parserBuilder();
    subject = subjectBuilder();
    super.setup();
  }

  @override
  void run() {
    final (result, _) = parser.run(subject.input);
    assert(Equality().equals(result, subject.result));
  }
}

class ParserBenchmarkData<Input, A> {
  final Input input;
  final A result;

  ParserBenchmarkData({required this.input, required this.result});
}

extension ParserBenchmarking<Input, A> on Parser<Input, A> {
  ParserBenchmark<Input, A> bench({
    required Input input,
    required A result,
  }) {
    return ParserBenchmark(
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

    for (var bench in benchmarks()) {
      bench.report();
    }
  }
}
