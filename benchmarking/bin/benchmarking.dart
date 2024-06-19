import 'package:benchmarking/cli.dart' as cli;

void main(List<String> arguments) {
  final repeat = 1000000;

  cli.BenchmarkIntParserStringInput().report();
  cli.BenchmarkIntParserCodeUnitsInput().report();

  cli.BenchmarkNestedFunctionsCall(repeat).report();
  cli.BenchmarkNestedClassesFunctionCall(repeat).report();

  cli.BenchmarkRepeatedClassInstantiation(repeat).report();
  cli.BenchmarkRepeatedFunctionCalls(repeat).report();
  cli.BenchmarkRecursiveClosureCall(repeat).report();
}
