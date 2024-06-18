import 'package:parsing/fp.dart';

mixin ParserMixin<Input, A> {
  (A?, Input) run(Input input);
}

extension ParserMixinTransformations<Input, A> on ParserMixin<Input, A> {
  MapParser<Input, B> map<B>(B Function(A) transform) {
    return MapParser(this, (dynamicA) => transform(dynamicA as A));
  }

  TakeParser<Input, A, B> take<B>(ParserMixin<Input, B> other) {
    return TakeParser(this, other);
  }

  TakeUnitParser<Input, A> takeUnit<B>(ParserMixin<Input, Unit> other) {
    return TakeUnitParser(this, other);
  }

  Skip<Input, A, B> skip<B>(ParserMixin<Input, B> other) {
    return Skip(this, other);
  }

  DebugParser<Input, A> debug() {
    return DebugParser(this);
  }

  (A?, Input, String?) runWithDebug(Input input) {
    final (result, rest) = this.run(input);
    final id = this.runtimeType.toString();
    if (result == null) {
      return (null, input, id);
    }
    return (result, rest, null);
  }
}

class OneOf<I, O> with ParserMixin<I, O> {
  final List<ParserMixin<I, O>> parsers;
  OneOf(this.parsers);

  @override
  (O?, I) run(I input) {
    for (final parser in parsers) {
      final (result, rest) = parser.run(input);
      if (result != null) {
        return (result, rest);
      }
    }
    return (null, input);
  }
}

class MapParser<Input, B> with ParserMixin<Input, B> {
  final ParserMixin<Input, dynamic> other;
  final B Function(dynamic) t;

  MapParser(this.other, this.t);

  @override
  (B?, Input) run(Input input) {
    final (a, rest) = other.run(input);
    if (a == null) {
      return (null, rest);
    }
    return (t(a), rest);
  }
}

class DebugParser<Input, A> with ParserMixin<Input, A> {
  final ParserMixin<Input, A> thisParser;

  DebugParser(this.thisParser);

  @override
  (A?, Input) run(Input input) {
    final (result, rest) = thisParser.run(input);
    if (result == null) {
      print("Error stack: ${StackTrace.current}");
      return (null, input);
    }
    return (result, rest);
  }
}

class TakeParser<Input, A, B> with ParserMixin<Input, (A, B)> {
  final ParserMixin<Input, A> parserA;
  final ParserMixin<Input, B> parserB;

  TakeParser(this.parserA, this.parserB);

  @override
  ((A, B)?, Input) run(Input input) {
    final (resultA, restA) = parserA.run(input);
    if (resultA == null) {
      return (null, input);
    }

    final (resultB, restB) = parserB.run(restA);
    if (resultB == null) {
      return (null, input);
    }
    return ((resultA, resultB), restB);
  }
}

class TakeParser3<Input, A, B, C> with ParserMixin<Input, (A, B, C)> {
  final ParserMixin<Input, (A, B)> parserAB;
  final ParserMixin<Input, C> parserC;

  TakeParser3(this.parserAB, this.parserC);

  @override
  ((A, B, C)?, Input) run(Input input) {
    return TakeParser(parserAB, parserC)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$2))
        .run(input);
  }
}

class TakeParser4<Input, A, B, C, D> with ParserMixin<Input, (A, B, C, D)> {
  final ParserMixin<Input, (A, B, C)> parserABC;
  final ParserMixin<Input, D> parserD;

  TakeParser4(this.parserABC, this.parserD);

  @override
  ((A, B, C, D)?, Input) run(Input input) {
    return TakeParser(parserABC, parserD)
        .map((tuple) => (tuple.$1.$1, tuple.$1.$2, tuple.$1.$3, tuple.$2))
        .run(input);
  }
}

class TakeFromUnitParser<Input, A> with ParserMixin<Input, A> {
  final ParserMixin<Input, Unit> thisParser;
  final ParserMixin<Input, A> otherParser;

  TakeFromUnitParser(this.thisParser, this.otherParser);

  @override
  (A?, Input) run(Input input) {
    return TakeParser(thisParser, otherParser)
        .map((tuple) => tuple.$2)
        .run(input);
  }
}

class TakeUnitParser<Input, A> with ParserMixin<Input, A> {
  final ParserMixin<Input, A> thisParser;
  final ParserMixin<Input, Unit> unitParser;

  TakeUnitParser(this.thisParser, this.unitParser);

  @override
  (A?, Input) run(Input input) {
    return TakeParser(thisParser, unitParser)
        .map((tuple) => tuple.$1)
        .run(input);
  }
}

class Skip<Input, A, B> with ParserMixin<Input, A> {
  final ParserMixin<Input, A> parserA;
  final ParserMixin<Input, B> parserB;

  Skip(this.parserA, this.parserB);

  @override
  (A?, Input) run(Input input) {
    final (resultA, restA) = parserA.run(input);
    if (resultA == null) {
      return (null, input);
    }

    final (resultB, restB) = parserB.run(restA);
    if (resultB == null) {
      return (null, input);
    }
    return (resultA, restB);
  }
}

class SkipFirst<Input, A> with ParserMixin<Input, Unit> {
  final ParserMixin<Input, A> first;

  SkipFirst(this.first);

  @override
  (Unit?, Input) run(Input input) {
    final (result, rest) = first.run(input);
    if (result == null) {
      return (null, input);
    }
    return (unit, rest);
  }
}

class StringPrefix with ParserMixin<String, String> {
  final String prefix;
  final int group;

  StringPrefix(this.prefix, [this.group = 0]);

  @override
  (String?, String) run(String input) {
    final regex = RegExp(prefix);
    final match = regex.matchAsPrefix(input);
    final group = match?.group(this.group);
    if (group == null) {
      return (null, input);
    }
    final rest = input.substring(group.length, input.length);
    return (group, rest);
  }
}

class IntParser with ParserMixin<String, int> {
  IntParser();

  @override
  (int?, String) run(String input) {
    return StringPrefix(r'\d+').map(int.parse).run(input);
  }
}

class OptionalParser<I, O> with ParserMixin<I, Optional<O>> {
  final ParserMixin<I, O> other;

  OptionalParser(this.other);

  @override
  (Optional<O>?, I) run(I input) {
    final (result, rest) = other.run(input);
    if (result == null) {
      return (None(), rest);
    }
    return (Some(result), rest);
  }
}

extension ParserTake3Transformations<Input, A, B>
    on ParserMixin<Input, (A, B)> {
  TakeParser3<Input, A, B, C> take<C>(ParserMixin<Input, C> other) {
    return TakeParser3(this, other);
  }
}

extension ParserTake4Transformations<Input, A, B, C>
    on ParserMixin<Input, (A, B, C)> {
  TakeParser4<Input, A, B, C, D> take<D>(ParserMixin<Input, D> other) {
    return TakeParser4(this, other);
  }
}

extension ParserTakeFromUnitTransformations<Input, A>
    on ParserMixin<Input, Unit> {
  TakeFromUnitParser<Input, A> take<A>(ParserMixin<Input, A> other) {
    return TakeFromUnitParser(this, other);
  }
}
