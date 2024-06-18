part of 'example.dart';

class UriParser<O> with ParserMixin<Uri?, O> {
  final ParserMixin<RequestInput, O> requestInputParser;
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

class End with ParserMixin<RequestInput, Unit> {
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

class Path<O> with ParserMixin<RequestInput, O> {
  final ParserMixin<String, O> parser;
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

    final (result, segmentRest) = parser.run(segment);
    if (segmentRest.isNotEmpty) {
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

class Query<O> with ParserMixin<RequestInput, O> {
  final String name;
  final ParserMixin<String, O> parser;
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
    final (result, paramRest) = parser.run(param);
    if (paramRest.isNotEmpty) {
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
final episodeMixin = Path(StringPrefix("episodes").map(toUnit))
    .take(Path(IntParser()))
    .take(OptionalParser(Query("time", IntParser())))
    .take(OptionalParser(Query("speed", IntParser().skip(StringPrefix("x")))))
    .takeUnit(End())
    .map(Route.episodes);

// episodes/42/comments
final episodeCommentsMixin = SkipFirst(Path(StringPrefix("episodes"))) //
    .take(Path(IntParser()))
    .skip(Path(StringPrefix("comments")))
    .takeUnit(End())
    .map(Route.episodeComments);

final routerMixin = UriParser(
  OneOf([
    episodeMixin,
    episodeCommentsMixin,
  ]),
);
