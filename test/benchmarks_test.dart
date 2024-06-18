import 'package:test/test.dart';

import '../benchmarking/benchmark_functions.dart';

void main() {
  test("running benchmarks", () {
    BenchmarkNestedFunctionsCall().report();
    BenchmarkNestedClassesCall().report();
  });
}
