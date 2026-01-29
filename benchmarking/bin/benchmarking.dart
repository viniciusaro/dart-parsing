import 'package:benchmarking/cli.dart' as cli;

void main(List<String> arguments) {
  // cli.intMaxIntSuite.report();
  // cli.intLongSuffixSuite.report();
  // cli.coordCollectionsSuite.report();

  // cli.doubleMaxDoubleSuite.report();
  // cli.doubleLongSuffixSuite.report();

  // cli.stringOperationsSuite.report();
  // cli.stringPrefixSuite.report();
  // cli.stringPrefixLongSuffixSuite.report();
  cli.stringSlicesSuite.report();

  // final repeat = 1000000;
  // cli.BenchmarkNestedFunctionsCall(repeat).report();
  // cli.BenchmarkNestedClassesFunctionCall(repeat).report();

  // cli.BenchmarkRepeatedClassInstantiation(repeat).report();
  // cli.BenchmarkRepeatedFunctionCalls(repeat).report();
  // cli.BenchmarkRecursiveClosureCall(repeat).report();
}
