part of 'parsing.dart';

class TakeParser<Input, A, B> with Parser<Input, (A, B)> {
  final Parser<Input, A> upstreamA;
  final Parser<Input, B> upstreamB;

  TakeParser(this.upstreamA, this.upstreamB);

  @override
  ((A, B), Input) run(Input input) {
    final tupleA = upstreamA.run(input);
    final tupleB = upstreamB.run(tupleA.$2);
    return ((tupleA.$1, tupleB.$1), tupleB.$2);
  }
}

class TakeParser3<Input, A, B, C> with Parser<Input, (A, B, C)> {
  final Parser<Input, (A, B)> upstreamAB;
  final Parser<Input, C> upstreamC;

  TakeParser3(this.upstreamAB, this.upstreamC);

  @override
  Parser<Input, (A, B, C)> body() {
    return TakeParser(upstreamAB, upstreamC)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2));
  }
}

class TakeParser4<Input, A, B, C, D> with Parser<Input, (A, B, C, D)> {
  final Parser<Input, (A, B, C)> upstreamABC;
  final Parser<Input, D> upstreamD;

  TakeParser4(this.upstreamABC, this.upstreamD);

  @override
  Parser<Input, (A, B, C, D)> body() {
    return TakeParser(upstreamABC, upstreamD)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2));
  }
}

class TakeFromUnitParser<Input, A> with Parser<Input, A> {
  final Parser<Input, Unit> upstreamUnit;
  final Parser<Input, A> upstreamA;

  TakeFromUnitParser(this.upstreamUnit, this.upstreamA);

  @override
  Parser<Input, A> body() {
    return TakeParser(upstreamUnit, upstreamA).map((tuple) => tuple.$2);
  }
}

class TakeUnitParser<Input, A> with Parser<Input, A> {
  final Parser<Input, A> upstreamA;
  final Parser<Input, Unit> upstreamUnit;

  TakeUnitParser(this.upstreamA, this.upstreamUnit);

  @override
  Parser<Input, A> body() {
    return TakeParser(upstreamA, upstreamUnit).map((tuple) => tuple.$1);
  }
}
