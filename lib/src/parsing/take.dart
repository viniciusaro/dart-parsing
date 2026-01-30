part of 'parsing.dart';

class TakeParser<A, B, Input> with Parser<(A, B), Input> {
  final Parser<A, Input> upstreamA;
  final Parser<B, Input> upstreamB;

  TakeParser(this.upstreamA, this.upstreamB);

  @override
  ((A, B), Input) run(Input input) {
    final tupleA = upstreamA.run(input);
    final tupleB = upstreamB.run(tupleA.$2);
    return ((tupleA.$1, tupleB.$1), tupleB.$2);
  }
}

class TakeParser3<A, B, C, Input> with Parser<(A, B, C), Input> {
  final Parser<(A, B), Input> upstreamAB;
  final Parser<C, Input> upstreamC;

  TakeParser3(this.upstreamAB, this.upstreamC);

  @override
  Parser<(A, B, C), Input> body() {
    return TakeParser(upstreamAB, upstreamC)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2));
  }
}

class TakeParser4<A, B, C, D, Input> with Parser<(A, B, C, D), Input> {
  final Parser<(A, B, C), Input> upstreamABC;
  final Parser<D, Input> upstreamD;

  TakeParser4(this.upstreamABC, this.upstreamD);

  @override
  Parser<(A, B, C, D), Input> body() {
    return TakeParser(upstreamABC, upstreamD)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2));
  }
}

class TakeFromUnitParser<A, Input> with Parser<A, Input> {
  final Parser<Unit, Input> upstreamUnit;
  final Parser<A, Input> upstreamA;

  TakeFromUnitParser(this.upstreamUnit, this.upstreamA);

  @override
  Parser<A, Input> body() {
    return TakeParser(upstreamUnit, upstreamA).map((tuple) => tuple.$2);
  }
}

class TakeUnitParser<A, Input> with Parser<A, Input> {
  final Parser<A, Input> upstreamA;
  final Parser<Unit, Input> upstreamUnit;

  TakeUnitParser(this.upstreamA, this.upstreamUnit);

  @override
  Parser<A, Input> body() {
    return TakeParser(upstreamA, upstreamUnit).map((tuple) => tuple.$1);
  }
}
