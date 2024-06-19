import 'package:benchmark_harness/benchmark_harness.dart';

class BenchmarkRepeatedFunctionCalls extends BenchmarkBase {
  final int repeat;
  const BenchmarkRepeatedFunctionCalls(this.repeat)
      : super("RepeatedFunctionCalls");

  @override
  void run() {
    int result = 0;
    for (var i = 0; i < repeat; i++) {
      result = _f();
    }
    assert(result == 1);
  }
}

int _f() {
  return 1;
}
