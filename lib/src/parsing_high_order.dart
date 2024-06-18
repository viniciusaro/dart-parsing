part of 'parsing.dart';

Parser<I, A> always<I, A>(A value) {
  return Parser<I, A>((input) => (value, input));
}

Parser<I, A> never<I, A>() {
  return Parser<I, A>(
    (input) => throw ParserError(expected: "never", remainingInput: input),
  );
}

Parser<I, I> prefix<I>(
  I candidate,
  I? Function(I input, I candidate) match,
  I Function(I input, I match) drop,
) {
  return Parser((input) {
    final matchResult = match(input, candidate);
    if (matchResult == null) {
      throw ParserError(
        expected: "$input match $candidate",
        remainingInput: input,
      );
    }
    final rest = drop(input, matchResult);
    return (matchResult, rest);
  });
}

Parser<I, O> oneOf<I, O>(core.List<Parser<I, O>> parsers) {
  return Parser((input) {
    final core.List<ParserError> failures = [];
    for (final parser in parsers) {
      try {
        return parser.run(input);
      } catch (e) {
        failures.add(ParserError.fromError(e));
      }
    }
    throw ParserError.fromMany(failures);
  });
}

Parser<I, O?> optional<I, O>(Parser<I, O> other) {
  return Parser((input) {
    try {
      return other.run(input);
    } catch (e) {
      return (null, input);
    }
  });
}
