part of 'parsing.dart';

extension ParserTransformations<I, A> on Parser<I, A> {
  Parser<I, B> map<B>(B Function(A) transform) {
    return Parser<I, B>((input) {
      final (a, rest) = run(input);
      if (a == null) {
        return (null, input);
      }
      return (transform(a), rest);
    });
  }

  Parser<I, B> flatMap<B>(Parser<I, B> Function(A) transform) {
    return Parser<I, B>((input) {
      final (a, restA) = run(input);
      if (a == null) {
        return (null, input);
      }
      final (b, restB) = transform(a).run(restA);
      if (b == null) {
        return (null, input);
      }
      return (b, restB);
    });
  }

  Parser<I, A> skip<B>(Parser<I, B> other) {
    return Parser((input) {
      final (a, restA) = this.run(input);
      if (a == null) {
        return (null, input);
      }
      final (_, restB) = other.run(restA);
      return (a, restB);
    });
  }

  Parser<I, (A, B)> take<B>(Parser<I, B> other) {
    return zip(this, other);
  }

  Parser<I, (A, B, C)> take3<B, C>(Parser<I, B> parserB, Parser<I, C> parserC) {
    return zip3(this, parserB, parserC);
  }
}

Parser<I, (A, B)> zip<I, A, B>(Parser<I, A> parserA, Parser<I, B> parserB) {
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
