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

  bool operator ==(Object other) {
    return other is Coordinate &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}
