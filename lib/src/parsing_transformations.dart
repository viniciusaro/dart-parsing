part of 'parsing.dart';

extension ParserTransformations<I, A> on Parser<I, A> {
  Parser<I, B> map<B>(B Function(A) transform) {
    return Parser<I, B>((input) {
      final (a, rest) = run(input);
      return (transform(a), rest);
    });
  }

  Parser<I, B> flatMap<B>(Parser<I, B> Function(A) transform) {
    return Parser<I, B>((input) {
      final (a, rest) = run(input);
      return transform(a).run(rest);
    });
  }

  Parser<I, A> skip<B>(Parser<I, B> other) {
    return Parser((input) {
      final (a, restA) = this.run(input);
      final (_, restB) = other.run(restA);
      return (a, restB);
    });
  }

  Parser<I, (A, B)> take<B>(Parser<I, B> other) {
    return zip(this, other);
  }

  Parser<I, A> takeUnit(Parser<I, Unit> other) {
    return zip(this, other).map((tuple) => tuple.$1);
  }
}

extension ParserVoidExtensions<I> on Parser<I, Unit> {
  Parser<I, B> take<B>(Parser<I, B> other) {
    return zip(this, other).map((tuple) => tuple.$2);
  }
}

extension ParserTuple3Extensions<I, A, B> on Parser<I, (A, B)> {
  Parser<I, (A, B, C)> take<C>(Parser<I, C> other) {
    return zip(this, other)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2));
  }
}

extension ParserTuple4Extensions<I, A, B, C> on Parser<I, (A, B, C)> {
  Parser<I, (A, B, C, D)> take<D>(Parser<I, D> other) {
    return zip(this, other)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2));
  }
}

Parser<I, (A, B)> zip<I, A, B>(Parser<I, A> parserA, Parser<I, B> parserB) {
  return Parser<I, (A, B)>((input) {
    final (a, restA) = parserA.run(input);
    final (b, restB) = parserB.run(restA);
    return ((a, b), restB);
  });
}

Parser<I, (A, B, C)> zip3<I, A, B, C>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
) {
  return zip(zip(parserA, parserB), parserC)
      .map((tuple3) => (tuple3.$1.$1, tuple3.$1.$2, tuple3.$2));
}

Parser<I, (A, B, C, D)> zip4<I, A, B, C, D>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
  Parser<I, D> parserD,
) {
  return zip(zip3(parserA, parserB, parserC), parserD)
      .map((tuple4) => (tuple4.$1.$1, tuple4.$1.$2, tuple4.$1.$3, tuple4.$2));
}

Parser<I, (A, B, C, D, E)> zip5<I, A, B, C, D, E>(
  Parser<I, A> parserA,
  Parser<I, B> parserB,
  Parser<I, C> parserC,
  Parser<I, D> parserD,
  Parser<I, E> parserE,
) {
  return zip(zip4(parserA, parserB, parserC, parserD), parserE).map((tuple5) =>
      (tuple5.$1.$1, tuple5.$1.$2, tuple5.$1.$3, tuple5.$1.$4, tuple5.$2));
}
