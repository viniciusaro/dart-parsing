part of 'parsing.dart';

class Skip<Input, A, B> with Parser<Input, A> {
  final Parser<Input, A> parserA;
  final Parser<Input, B> parserB;

  Skip(this.parserA, this.parserB);

  @override
  (A, Input) run(Input input) {
    final tupleA = parserA.run(input);
    final tupleB = parserB.run(tupleA.$2);
    return (tupleA.$1, tupleB.$2);
  }
}

class SkipFirst<Input, A> with Parser<Input, Unit> {
  final Parser<Input, A> first;

  SkipFirst(this.first);

  @override
  (Unit, Input) run(Input input) {
    return first.map((_) => unit).run(input);
  }
}
