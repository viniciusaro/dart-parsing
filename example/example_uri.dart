part of 'example.dart';

Parser<UriInput, O> path<O>(Parser<String, O> parser) {
  return Parser((uri) {
    final segment = uri.pathSegments.firstOrNull;
    if (segment == null) {
      return (null, uri);
    }
    final (result, rest) = parser.run(segment);
    if (rest.isNotEmpty) {
      return (null, uri);
    }
    uri.pathSegments.removeAt(0);
    return (result, uri);
  });
}

Parser<UriInput, O> query<O>(String name, Parser<String, O> parser) {
  return Parser((uri) {
    final param = uri.queryParameters[name];
    if (param == null) {
      return (null, uri);
    }
    final (result, rest) = parser.run(param);
    if (rest.isNotEmpty) {
      return (null, uri);
    }
    uri.queryParameters.remove(name);
    return (result, uri);
  });
}

Parser<UriInput, Unit> end<O>() {
  return Parser((uri) {
    if (uri.pathSegments.isNotEmpty) {
      return (null, uri);
    }
    return (unit, uri);
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
