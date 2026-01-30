part of 'parsing.dart';

class Skip<A, B, Input> with Parser<A, Input> {
  final Parser<A, Input> upstreamA;
  final Parser<B, Input> upstreamB;

  Skip(this.upstreamA, this.upstreamB);

  @override
  (A, Input) run(Input input) {
    final tupleA = upstreamA.run(input);
    final tupleB = upstreamB.run(tupleA.$2);
    return (tupleA.$1, tupleB.$2);
  }
}

class SkipFirst<A, Input> with Parser<Unit, Input> {
  final Parser<A, Input> upstream;

  SkipFirst(this.upstream);

  @override
  Parser<Unit, Input> body() {
    return upstream.map((_) => unit);
  }
}
