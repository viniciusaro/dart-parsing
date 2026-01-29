import 'package:benchmarking/parsers.dart';

final stringSlicesSuite = BenchmarkSuite(
  "String slices",
  () {
    final escalation = 1000;
    final escalatedString = List.generate(escalation, (_) => lipsum).join("\n");

    return [
      OperationBenchmark(
        "slices access ($escalation)",
        () {
          final string = BenchmarkStringSlice(escalatedString);
          for (var i = 0; i < string.length / 2; i++) {
            final _ = string.substring(i, string.length - i);
          }
        },
      ),
      OperationBenchmark(
        "mutable slices access ($escalation)",
        () {
          final string = MutableBenchmarkStringSlice(escalatedString);
          for (var i = 0; i < string.length / 2; i++) {
            string.substring(i, string.length - i);
          }
        },
      ),
      OperationBenchmark(
        "code unit at access ($escalation)",
        () {
          final string = escalatedString;
          for (var i = 0; i < string.length / 2; i++) {
            final _ = string.codeUnitAt(i);
          }
        },
      ),
      OperationBenchmark(
        "code units access ($escalation)",
        () {
          final string = escalatedString;
          for (var i = 0; i < string.length / 2; i++) {
            final _ = string.codeUnits[i];
          }
        },
      ),
      OperationBenchmark(
        "code units skip access ($escalation)",
        () {
          final string = escalatedString;
          for (var i = 0; i < string.length / 2; i++) {
            final _ = string.codeUnits.skip(i);
          }
        },
      ),
      if (escalation < 10)
        OperationBenchmark(
          "substring access ($escalation)",
          () {
            final string = escalatedString;
            for (var i = 0; i < string.length / 2; i++) {
              final _ = string.substring(i, string.length - i);
            }
          },
        ),
    ];
  },
);

final class BenchmarkStringSlice {
  final String source;
  final int startIndex;
  final int endIndex;

  BenchmarkStringSlice(this.source)
      : startIndex = 0,
        endIndex = source.length - 1;

  BenchmarkStringSlice._(
    this.source,
    this.startIndex,
    this.endIndex,
  );

  int get length => endIndex - startIndex + 1;

  BenchmarkStringSlice substring(int startIndex, int endIndex) {
    return BenchmarkStringSlice._(source, startIndex, endIndex);
  }

  @override
  String toString() {
    return source.substring(startIndex, endIndex);
  }
}

final class MutableBenchmarkStringSlice {
  final String source;
  int startIndex;
  int endIndex;

  MutableBenchmarkStringSlice(this.source)
      : startIndex = 0,
        endIndex = source.length - 1;

  MutableBenchmarkStringSlice._(
    this.source,
    this.startIndex,
    this.endIndex,
  );

  int get length => endIndex - startIndex + 1;

  void substring(int startIndex, int endIndex) {
    this.startIndex = startIndex;
    this.endIndex = endIndex;
  }

  @override
  String toString() {
    return source.substring(startIndex, endIndex);
  }
}
