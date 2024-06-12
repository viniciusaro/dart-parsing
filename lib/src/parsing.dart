import 'dart:core' as core;

import 'package:fpdart/fpdart.dart';

part 'parsing_higher_order_parsers.dart';
part 'parsing_transformations.dart';

class Parser<A> {
  final (A?, core.String) Function(core.String) run;
  Parser(this.run);
}
