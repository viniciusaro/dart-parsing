import 'package:benchmark_harness/benchmark_harness.dart';

int _count = 0;
int _repeat = 0;

class BenchmarkNestedClassesFunctionCall extends BenchmarkBase {
  final int repeat;
  const BenchmarkNestedClassesFunctionCall(this.repeat)
      : super("NestedClassesFunctionCall");

  @override
  void run() {
    _repeat = repeat;
    assert(_A1().f() == 1);
  }
}

class _A1 {
  int f() {
    return _A2().f();
  }
}

class _A2 {
  int f() {
    return _A3().f();
  }
}

class _A3 {
  int f() {
    return _A4().f();
  }
}

class _A4 {
  int f() {
    return _A5().f();
  }
}

class _A5 {
  int f() {
    return _A6().f();
  }
}

class _A6 {
  int f() {
    return _A7().f();
  }
}

class _A7 {
  int f() {
    return _A8().f();
  }
}

class _A8 {
  int f() {
    return _A9().f();
  }
}

class _A9 {
  int f() {
    return _A10().f();
  }
}

class _A10 {
  int f() {
    if (_count < _repeat) {
      _count += 1;
      return _A1().f();
    }
    return 1;
  }
}
