import 'dart:core' as core;

part 'parsing_high_order.dart';
part 'parsing_transformations.dart';

class Parser<Input, Output> {
  final (Output?, Input) Function(Input) run;
  Parser(this.run);
}
