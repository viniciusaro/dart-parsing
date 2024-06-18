part of 'parsing.dart';

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

Parser<I, O> oneOf<I, O>(core.List<Parser<I, O>> parsers) {
  return Parser((input) {
    for (final parser in parsers) {
      final (result, rest) = parser.run(input);
      if (result != null) {
        return (result, rest);
      }
    }
    return (null, input);
  });
}

Parser<I, Optional<O>> optional<I, O>(Parser<I, O> other) {
  return Parser((input) {
    final (result, rest) = other.run(input);
    if (result != null) {
      return (Some(result), rest);
    } else {
      return (None<O>(), rest);
    }
  });
}
