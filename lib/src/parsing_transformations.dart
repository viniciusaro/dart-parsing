part of 'parsing.dart';

extension ParserTransformations<I, O> on Parser<I, O> {
  Parser<I, O2> map<O2>(O2 Function(O) transform) {
    return Parser<I, O2>((input) {
      final (a, rest) = run(input);
      if (a == null) {
        return (null, input);
      }
      return (transform(a), rest);
    });
  }

  Parser<I, O2> flatMap<O2>(Parser<I, O2> Function(O) transform) {
    return Parser<I, O2>((string) {
      final (a, restA) = run(string);
      if (a == null) {
        return (null, string);
      }
      final (b, restB) = transform(a).run(restA);
      if (b == null) {
        return (null, string);
      }
      return (b, restB);
    });
  }
}

Parser<I, (A, B)> zip2<I, A, B>(Parser<I, A> parserA, Parser<I, B> parserB) {
  return Parser<I, (A, B)>((string) {
    final (a, restA) = parserA.run(string);
    if (a == null) {
      return (null, string);
    }
    final (b, restB) = parserB.run(restA);
    if (b == null) {
      return (null, string);
    }
    return ((a, b), restB);
  });
}

Parser<I, (A, B, C)> zip3<I, A, B, C>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
) {
  return zip2(zip2(parserA, parserB), parserC)
      .map((tuple3) => (tuple3.$1.$1, tuple3.$1.$2, tuple3.$2));
}

Parser<I, (A, B, C, D)> zip4<I, A, B, C, D>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
  Parser<I, D> parserD,
) {
  return zip2(zip3(parserA, parserB, parserC), parserD)
      .map((tuple4) => (tuple4.$1.$1, tuple4.$1.$2, tuple4.$1.$3, tuple4.$2));
}

Parser<I, (A, B, C, D, E)> zip5<I, A, B, C, D, E>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
  Parser<I, D> parserD,
  Parser<I, E> parserE,
) {
  return zip2(zip4(parserA, parserB, parserC, parserD), parserE).map((tuple5) =>
      (tuple5.$1.$1, tuple5.$1.$2, tuple5.$1.$3, tuple5.$1.$4, tuple5.$2));
}

extension IterableExtension<T> on core.Iterable<T> {
  core.bool startsWith(core.Iterable<T> prefix) {
    if (prefix.length > this.length) {
      return false;
    }
    for (var i = 0; i < prefix.length; i++) {
      if (prefix.elementAt(i) != this.elementAt(i)) {
        return false;
      }
    }
    return true;
  }
}
