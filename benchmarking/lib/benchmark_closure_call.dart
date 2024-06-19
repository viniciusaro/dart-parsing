import 'package:benchmark_harness/benchmark_harness.dart';

int _count = 0;

class BenchmarkRecursiveClosureCall extends BenchmarkBase {
  final int repeat;

  const BenchmarkRecursiveClosureCall(this.repeat)
      : super("RecursiveClosureCall");

  @override
  void run() {
    assert(_f(repeat) == 1);
  }
}

int _f(int repeat) {
  int f(int Function() g) {
    if (_count < repeat) {
      _count += g();
      return _f(repeat);
    }
    return g();
  }

  return f(() => 1);
}
