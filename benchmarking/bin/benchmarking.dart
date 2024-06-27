import 'package:benchmarking/cli.dart' as cli;

void main(List<String> arguments) {
  // final repeat = 1000000;

  cli.BenchmarkIntParserRegex().report();
  cli.BenchmarkIntParserStringPrefix().report();
  cli.BenchmarkIntParserCodeUnits().report();
  cli.BenchmarkIntParserCodeUnitsPrefix().report();
  cli.BenchmarkIntParserRunesPrefix().report();
  cli.BenchmarkIntParserBytesPrefix().report();

  // cli.BenchmarkNestedFunctionsCall(repeat).report();
  // cli.BenchmarkNestedClassesFunctionCall(repeat).report();

  // cli.BenchmarkRepeatedClassInstantiation(repeat).report();
  // cli.BenchmarkRepeatedFunctionCalls(repeat).report();
  // cli.BenchmarkRecursiveClosureCall(repeat).report();
}
