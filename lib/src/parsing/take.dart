part of 'parsing.dart';

class TakeParser<Input, A, B> with Parser<Input, (A, B)> {
  final Parser<Input, A> parserA;
  final Parser<Input, B> parserB;

  TakeParser(this.parserA, this.parserB);

  @override
  ((A, B), Input) run(Input input) {
    late (A, Input) tupleA;
    late (B, Input) tupleB;

    try {
      tupleA = parserA.run(input);
    } catch (e) {
      throw ParserError.fromError(e);
    }

    try {
      tupleB = parserB.run(tupleA.$2);
    } catch (e) {
      throw ParserError.fromError(e);
    }

    return ((tupleA.$1, tupleB.$1), tupleB.$2);
  }
}

class TakeParser3<Input, A, B, C> with Parser<Input, (A, B, C)> {
  final Parser<Input, (A, B)> parserAB;
  final Parser<Input, C> parserC;

  TakeParser3(this.parserAB, this.parserC);

  @override
  Parser<Input, (A, B, C)> body() {
    return TakeParser(parserAB, parserC)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2));
  }
}

class TakeParser4<Input, A, B, C, D> with Parser<Input, (A, B, C, D)> {
  final Parser<Input, (A, B, C)> parserABC;
  final Parser<Input, D> parserD;

  TakeParser4(this.parserABC, this.parserD);

  @override
  Parser<Input, (A, B, C, D)> body() {
    return TakeParser(parserABC, parserD)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2));
  }
}

class TakeFromUnitParser<Input, A> with Parser<Input, A> {
  final Parser<Input, Unit> thisParser;
  final Parser<Input, A> otherParser;

  TakeFromUnitParser(this.thisParser, this.otherParser);

  @override
  Parser<Input, A> body() {
    return TakeParser(thisParser, otherParser).map((tuple) => tuple.$2);
  }
}

class TakeUnitParser<Input, A> with Parser<Input, A> {
  final Parser<Input, A> thisParser;
  final Parser<Input, Unit> unitParser;

  TakeUnitParser(this.thisParser, this.unitParser);

  @override
  Parser<Input, A> body() {
    return TakeParser(thisParser, unitParser).map((tuple) => tuple.$1);
  }
}
