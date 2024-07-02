part of 'example.dart';

final class Coordinate {
  final double latitude;
  final double longitude;

  factory Coordinate.tuple((double, double) latLng) {
    final latitude = latLng.$1;
    final longitude = latLng.$2;
    return Coordinate(latitude, longitude);
  }

  Coordinate(this.latitude, this.longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ 31;

  @override
  bool operator ==(Object other) {
    return other is Coordinate &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}

final class Race extends Equatable {
  final City city;
  final Iterable<Coordinate> path;

  factory Race.tuple((City, Iterable<Coordinate>) tuple) {
    return Race(tuple.$1, tuple.$2);
  }

  Race(this.city, this.path);

  @override
  List<Object?> get props => [city, path];
}

final class Races extends Equatable {
  final Iterable<Race> races;

  Races(this.races);

  @override
  List<Object?> get props => [races];
}
