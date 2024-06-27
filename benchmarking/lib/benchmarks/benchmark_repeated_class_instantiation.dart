import 'package:benchmark_harness/benchmark_harness.dart';

class BenchmarkRepeatedClassInstantiation extends BenchmarkBase {
  final int repeat;

  const BenchmarkRepeatedClassInstantiation(this.repeat)
      : super("RepeatedClassInstantiation");

  @override
  void run() {
    int result = 0;
    for (var i = 0; i < repeat; i++) {
      result = _A1().f();
    }
    assert(result == 1);
  }
}

class _A1 {
  int f() {
    return 1;
  }
}
