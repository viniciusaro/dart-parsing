part of 'example.dart';

Parser<Uri?, O> uri<O>(Parser<RequestInput, O> requestInput) {
  return Parser((uri) {
    final (result, rest) = requestInput.run(RequestInput(uri!));
    if (rest != RequestInput.empty()) {
      throw ParserError(
        expected: "request input to be fully consumed",
        remainingInput: rest,
      );
    }
    return (result, null);
  });
}

Parser<RequestInput, O> path<O>(Parser<String, O> parser) {
  return Parser((input) {
    final segment = input.pathSegments.firstOrNull;
    if (segment == null) {
      throw ParserError(expected: "segment to parse", remainingInput: input);
    }
    final (result, rest) = parser.run(segment);
    if (rest.isNotEmpty) {
      throw ParserError(
        expected: "segment to be fully consumed",
        remainingInput: rest,
      );
    }
    input.pathSegments.removeAt(0);
    return (result, input);
  });
}

Parser<RequestInput, O> query<O>(String name, Parser<String, O> parser) {
  return Parser((input) {
    final param = input.queryParameters[name];
    if (param == null) {
      throw ParserError(expected: "param to parse", remainingInput: input);
    }
    final (result, rest) = parser.run(param);
    if (rest.isNotEmpty) {
      throw ParserError(
        expected: "param to be fully consumed",
        remainingInput: rest,
      );
    }
    input.queryParameters.remove(name);
    return (result, input);
  });
}

// episodes/42
// episodes/42?time=120&speed=2x
final episode = uri(
  path(string.prefix("episodes").map(toUnit))
      .take(path(string.int))
      .take(optional(query("time", string.int)))
      .take(optional(query("speed", string.int.skip(string.prefix("x")))))
      .map(Route.episodes),
);

// episodes/42/comments
final episodeComments = uri(
  path(string.prefix("episodes").map(toUnit))
      .take(path(string.int))
      .skip(path(string.prefix("comments")))
      .map(Route.episodeComments),
);

final router = oneOf([
  episode,
  episodeComments,
]);
