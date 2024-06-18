import 'package:benchmark_harness/benchmark_harness.dart';

int f() {
  int f() {
    int f() {
      int f() {
        int f() {
          int f() {
            int f() {
              int f() {
                int f() {
                  int f() {
                    return 1;
                  }

                  return f();
                }

                return f();
              }

              return f();
            }

            return f();
          }

          return f();
        }

        return f();
      }

      return f();
    }

    return f();
  }

  return f();
}

class BenchmarkNestedFunctionsCall extends BenchmarkBase {
  const BenchmarkNestedFunctionsCall() : super("NestedFunctionsCall");

  @override
  void run() {
    assert(f() == 1);
  }
}

class A1 {
  int f() {
    return A2().f();
  }
}

class A2 {
  int f() {
    return A3().f();
  }
}

class A3 {
  int f() {
    return A4().f();
  }
}

class A4 {
  int f() {
    return A5().f();
  }
}

class A5 {
  int f() {
    return A6().f();
  }
}

class A6 {
  int f() {
    return A7().f();
  }
}

class A7 {
  int f() {
    return A8().f();
  }
}

class A8 {
  int f() {
    return A9().f();
  }
}

class A9 {
  int f() {
    return A10().f();
  }
}

class A10 {
  int f() {
    return 1;
  }
}

class BenchmarkNestedClassesCall extends BenchmarkBase {
  const BenchmarkNestedClassesCall() : super("NestedClassesCall");

  @override
  void run() {
    assert(A1().f() == 1);
  }
}
