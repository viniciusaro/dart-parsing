import 'dart:core' as core;

import 'package:fpdart/fpdart.dart';

class Parser<A> {
  final (A?, core.String) Function(core.String) run;
  Parser(this.run);
}

extension ParserMap<A> on Parser<A> {
  // map: ((A) -> B) -> (F<A>) -> F<B>
  Parser<B> map<B>(B Function(A) transform) {
    return Parser<B>((string) {
      final (a, rest) = run(string);
      if (a == null) {
        return (null, string);
      }
      return (transform(a), rest);
    });
  }

  // flatMap: ((A) -> F<B>) -> (F<A>) -> F<B>
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

// zip: (F<A>, F<B>) -> F<(A, B)>
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

Parser<core.String> prefix({required core.String pattern}) {
  return Parser<core.String>((string) {
    final regex = core.RegExp("$pattern");
    final match = regex.matchAsPrefix(string);
    final group = match?.group(0);
    final result = group;
    final rest = string.substring(group?.length ?? 0, string.length);
    return (result, rest);
  });
}

Parser<core.String> literal(core.String literal) => prefix(pattern: literal);

final char = prefix(pattern: r'[a-z|A-Z]');
final int = prefix(pattern: r'\d+').map(core.int.parse);
final double = prefix(pattern: r'\d+([,|.]?\d)*')
    .map((string) => string.replaceAll(",", "."))
    .map(core.double.parse);

final zeroOrMoreSpaces = prefix(pattern: r' ').map((_) => unit);

final oneOrMoreSpaces = prefix(pattern: r' +')
    .flatMap((spaces) => spaces.isNotEmpty ? always(unit) : never<Unit>());

Parser<A> always<A>(A value) {
  return Parser((string) => (value, string));
}

Parser<A> never<A>() {
  return Parser<A>((string) => (null, string));
}
