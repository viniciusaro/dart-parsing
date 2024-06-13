part of 'example.dart';

class UriInput extends Equatable {
  final List<String> pathSegments;
  final Map<String, String> queryParameters;

  UriInput(Uri source)
      : pathSegments = List.from(source.pathSegments),
        queryParameters = Map.from(source.queryParameters);

  UriInput._(this.pathSegments, this.queryParameters);
  factory UriInput.empty() => UriInput._([], {});
  factory UriInput.parse(String string) => UriInput(Uri.parse(string));

  @override
  List<Object?> get props => [pathSegments, queryParameters];
}

sealed class Route {
  static Route episodes((int, Optional<int>, Optional<int>) tuple) =>
      Episodes.tuple(tuple);

  static Route episodeComments(int id) => //
      EpisodeComments(id: id);
}

class Episodes extends Route with EquatableMixin {
  final int id;
  final int? time;
  final int? speed;

  @override
  List<Object?> get props => [id, time, speed];

  Episodes({required this.id, this.time, this.speed});

  static Episodes tuple(
    (int, Optional<int>, Optional<int>) tuple,
  ) =>
      Episodes(
        id: tuple.$1,
        time: tuple.$2.optional,
        speed: tuple.$3.optional,
      );
}

class EpisodeComments extends Route with EquatableMixin {
  final int id;

  @override
  List<Object?> get props => [id];

  EpisodeComments({required this.id});
}
