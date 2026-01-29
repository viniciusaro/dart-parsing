part of 'example.dart';

class UriParser<O> with Parser<O, Uri?> {
  final Parser<O, RequestInput> requestInputParser;
  UriParser(this.requestInputParser);

  @override
  (O, Uri?) run(Uri? input) {
    final (result, rest) = requestInputParser.run(RequestInput(input!));
    if (rest != RequestInput.empty()) {
      throw ParserError(
        expected: "request input to be fully consumed",
        remainingInput: rest,
      );
    }
    return (result, null);
  }
}

class End with Parser<Unit, RequestInput> {
  @override
  (Unit, RequestInput) run(RequestInput input) {
    if (input != RequestInput.empty()) {
      throw ParserError(
        expected: "request input to be fully consumed",
        remainingInput: input,
      );
    }
    return (unit, input);
  }
}

class Path<O> with Parser<O, RequestInput> {
  final Parser<O, IterableCollection<int>> parser;
  Path(this.parser);

  @override
  (O, RequestInput) run(RequestInput input) {
    final segment = input.pathSegments.firstOrNull;
    if (segment == null) {
      throw ParserError(
        expected: "segment to parse",
        remainingInput: input,
      );
    }

    final (result, segmentRest) = parser.run(segment.codeUnits.collection);
    if (segmentRest.length > 0) {
      throw ParserError(
        expected: "segment to be fully consumed",
        remainingInput: input,
      );
    }

    final rest = input.copy();
    rest.pathSegments.removeAt(0);
    return (result, rest);
  }
}

class Query<O> with Parser<O, RequestInput> {
  final String name;
  final Parser<O, IterableCollection<int>> parser;
  Query(this.name, this.parser);

  @override
  (O, RequestInput) run(RequestInput input) {
    final param = input.queryParameters[name];
    if (param == null) {
      throw ParserError(
        expected: "param to parse",
        remainingInput: input,
      );
    }
    final (result, paramRest) = parser.run(param.codeUnits.collection);
    if (paramRest.length > 0) {
      throw ParserError(
        expected: "param to be fully consumed",
        remainingInput: input,
      );
    }

    final rest = input.copy();
    rest.queryParameters.remove(name);
    return (result, rest);
  }
}

// episodes/42
// episodes/42?time=120&speed=2x
final episode = Path(StringLiteral("episodes").map(toUnit))
    .take(Path(IntParser()))
    .take(OptionalParser(Query("time", IntParser())))
    .take(OptionalParser(Query("speed", IntParser().skip(StringLiteral("x")))))
    .takeUnit(End())
    .map(Route.episodes);

// episodes/42/comments
final episodeComments = SkipFirst(Path(StringLiteral("episodes"))) //
    .take(Path(IntParser()))
    .skip(Path(StringLiteral("comments")))
    .takeUnit(End())
    .map(Route.episodeComments);

final router = UriParser(
  OneOf([
    episode,
    episodeComments,
  ]),
);
