part of 'example.dart';

Parser<RequestInput, O> path<O>(Parser<String, O> parser) {
  return Parser((input) {
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
  });
}

Parser<RequestInput, O> query<O>(String name, Parser<String, O> parser) {
  return Parser((input) {
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
  });
}

Parser<RequestInput, Unit> end<O>() {
  return Parser((input) {
    if (input.pathSegments.isNotEmpty) {
      return (null, input);
    }
    input.queryParameters.clear();
    return (unit, input);
  });
}

// episodes/42
// episodes/42?time=120&speed=2x
final episode = path(string.prefix("episodes").map(toUnit))
    .take(path(string.int))
    .take(optional(query("time", string.int)))
    .take(optional(query("speed", string.int.skip(string.prefix("x")))))
    .skip(end())
    .map(Route.episodes);

// episodes/42/comments
final episodeComments = path(string.prefix("episodes").map(toUnit))
    .take(path(string.int))
    .skip(path(string.prefix("comments")))
    .skip(end())
    .map(Route.episodeComments);
