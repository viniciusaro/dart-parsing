part of '../parsing.dart';

class Prefix<C extends RangeReplaceableCollection<C, E>, E> with Parser<C, C> {
  final bool Function(E) predicate;

  Prefix(this.predicate);

  @override
  (C, C) run(C input) {
    late C match;
    late C rest;

    try {
      match = input.prefix(predicate);
      rest = input.removeFirst(match.length);
    } catch (e, s) {
      final error = ParserError(
        expected: "${C.runtimeType}",
        remainingInput: input,
      );
      throw Error.throwWithStackTrace(error, s);
    }

    if (match.length == 0) {
      throw ParserError(
        expected: "Non empty ${C}",
        remainingInput: input,
      );
    }
    return (match, rest);
  }
}
