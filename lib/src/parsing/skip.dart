part of 'parsing.dart';

class Skip<Input, A, B> with Parser<Input, A> {
  final Parser<Input, A> upstreamA;
  final Parser<Input, B> upstreamB;

  Skip(this.upstreamA, this.upstreamB);

  @override
  (A, Input) run(Input input) {
    final tupleA = upstreamA.run(input);
    final tupleB = upstreamB.run(tupleA.$2);
    return (tupleA.$1, tupleB.$2);
  }
}

class SkipFirst<Input, A> with Parser<Input, Unit> {
  final Parser<Input, A> upstream;

  SkipFirst(this.upstream);

  @override
  Parser<Input, Unit> body() {
    return upstream.map((_) => unit);
  }
}
