import 'package:benchmarking/cli.dart' as cli;

void main(List<String> arguments) {
  // cli.intMaxIntSuite.report();
  // cli.intLongSuffixSuite.report();

  cli.doubleMaxDoubleSuite.report();
  cli.doubleLongSuffixSuite.report();

  // final repeat = 1000000;
  // cli.BenchmarkNestedFunctionsCall(repeat).report();
  // cli.BenchmarkNestedClassesFunctionCall(repeat).report();

  // cli.BenchmarkRepeatedClassInstantiation(repeat).report();
  // cli.BenchmarkRepeatedFunctionCalls(repeat).report();
  // cli.BenchmarkRecursiveClosureCall(repeat).report();
}
