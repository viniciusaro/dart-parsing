import 'package:benchmark_harness/benchmark_harness.dart';

int _count = 0;
int _repeat = 0;

class BenchmarkNestedFunctionsCall extends BenchmarkBase {
  final int repeat;
  const BenchmarkNestedFunctionsCall(this.repeat)
      : super("NestedFunctionsCall");

  @override
  void run() {
    _repeat = repeat;
    assert(_f() == 1);
  }
}

int _f() {
  int fNested() {
    int fNested() {
      int fNested() {
        int fNested() {
          int fNested() {
            int fNested() {
              int fNested() {
                int fNested() {
                  int fNested() {
                    if (_count < _repeat) {
                      _count += 1;
                      return _f();
                    }
                    return 1;
                  }

                  return fNested();
                }

                return fNested();
              }

              return fNested();
            }

            return fNested();
          }

          return fNested();
        }

        return fNested();
      }

      return fNested();
    }

    return fNested();
  }

  return fNested();
}
