import 'dart:core' as core;

part 'parsing_transformations.dart';

class Parser<Input, Output> {
  final (Output?, Input) Function(Input) run;
  Parser(this.run);
}

Parser<I, A> always<I, A>(A value) {
  return Parser<I, A>((string) => (value, string));
}

Parser<I, A> never<I, A>() {
  return Parser<I, A>((string) => (null, string));
}

Parser<I, I> prefix<I>(
  I candidate,
  I? Function(I input, I candidate) match,
  I Function(I input, I match) drop,
) {
  return Parser((input) {
    final matchResult = match(input, candidate);
    if (matchResult == null) {
      return (null, input);
    }
    final rest = drop(input, matchResult);
    return (matchResult, rest);
  });
}
