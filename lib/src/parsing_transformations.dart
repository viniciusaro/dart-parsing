part of 'parsing.dart';

extension ParserTransformations<A> on Parser<A> {
  Parser<B> map<B>(B Function(A) transform) {
    return Parser<B>((string) {
      final (a, rest) = run(string);
      if (a == null) {
        return (null, string);
      }
      return (transform(a), rest);
    });
  }

  Parser<B> flatMap<B>(Parser<B> Function(A) transform) {
    return Parser<B>((string) {
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

Parser<(A, B)> zip2<A, B>(Parser<A> parserA, Parser<B> parserB) {
  return Parser<(A, B)>((string) {
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

Parser<(A, B, C)> zip3<A, B, C>(
  Parser<A> parserA,
  Parser<B> parserB,
  Parser<C> parserC,
) {
  return zip2(zip2(parserA, parserB), parserC)
      .map((tuple3) => (tuple3.$1.$1, tuple3.$1.$2, tuple3.$2));
}

Parser<(A, B, C, D)> zip4<A, B, C, D>(
  Parser<A> parserA,
  Parser<B> parserB,
  Parser<C> parserC,
  Parser<D> parserD,
) {
  return zip2(zip3(parserA, parserB, parserC), parserD)
      .map((tuple4) => (tuple4.$1.$1, tuple4.$1.$2, tuple4.$1.$3, tuple4.$2));
}

Parser<(A, B, C, D, E)> zip5<A, B, C, D, E>(
  Parser<A> parserA,
  Parser<B> parserB,
  Parser<C> parserC,
  Parser<D> parserD,
  Parser<E> parserE,
) {
  return zip2(zip4(parserA, parserB, parserC, parserD), parserE).map((tuple5) =>
      (tuple5.$1.$1, tuple5.$1.$2, tuple5.$1.$3, tuple5.$1.$4, tuple5.$2));
}
