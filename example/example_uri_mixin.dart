part of 'example.dart';

class UriParser<O> with ParserMixin<Optional<Uri>, O> {
  final ParserMixin<RequestInput, O> requestInputParser;
  UriParser(this.requestInputParser);

  @override
  (O?, Optional<Uri>) run(Optional<Uri> input) {
    final nonOptionalInput = input.optional;
    if (nonOptionalInput == null) {
      return (null, None());
    }

    final requestInput = RequestInput(nonOptionalInput);
    final (result, rest) = requestInputParser.run(requestInput);
    if (result == null || rest != RequestInput.empty()) {
      return (null, Some(nonOptionalInput));
    }
    return (result, None());
  }
}

class End with ParserMixin<RequestInput, Unit> {
  @override
  (Unit?, RequestInput) run(RequestInput input) {
    if (input.pathSegments.isNotEmpty) {
      return (null, input);
    }
    return (unit, input);
  }
}

class Path<O> with ParserMixin<RequestInput, O> {
  final ParserMixin<String, O> parser;
  Path(this.parser);

  @override
  (O?, RequestInput) run(RequestInput input) {
    final segment = input.pathSegments.firstOrNull;
    if (segment == null) {
      return (null, input);
    }
    final (result, rest) = parser.run(segment);
    if (rest.isNotEmpty) {
      return (null, input);
    }
    input.pathSegments.removeAt(0);
    return (result, input);
  }
}

class Query<O> with ParserMixin<RequestInput, O> {
  final String name;
  final ParserMixin<String, O> parser;
  Query(this.name, this.parser);

  @override
  (O?, RequestInput) run(RequestInput input) {
    final param = input.queryParameters[name];
    if (param == null) {
      return (null, input);
    }
    final (result, rest) = parser.run(param);
    if (rest.isNotEmpty) {
      return (null, input);
    }
    input.queryParameters.remove(name);
    return (result, input);
  }
}

// episodes/42?time=120&speed=2x
final episodeMixin = SkipFirst(Path(StringPrefix("episodes"))) //
    .take(Path(IntParser()))
    .take(OptionalParser(Query("time", IntParser())))
    .take(OptionalParser(Query("speed", IntParser())))
    .takeUnit(End())
    .map(Route.episodes)
    .debug();

// episodes/42/comments
final episodeCommentsMixin = SkipFirst(Path(StringPrefix("episodes"))) //
    .take(Path(IntParser()))
    .skip(Path(StringPrefix("comments")))
    .takeUnit(End())
    .map(Route.episodeComments)
    .debug();

final routerMixin = UriParser(
  OneOf([
    episodeMixin,
    episodeCommentsMixin,
  ]),
);
