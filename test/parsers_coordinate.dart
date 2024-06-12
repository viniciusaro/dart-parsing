import 'dart:core';
import 'package:parsing/parsing.dart';
import 'package:parsing/string.dart' as string;

// "15.832373° S, 47.987751° W"
final class Coordinate {
  final double latitude;
  final double longitude;
  Coordinate(this.latitude, this.longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ 31;

  bool operator ==(Object other) {
    return other is Coordinate &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}

final northSouthSign = string.char.flatMap((char) {
  return char == "N"
      ? always(1)
      : char == "S"
          ? always(-1)
          : never<String, int>();
});

final eastWestSign = string.char.flatMap((char) {
  return char == "E"
      ? always(1)
      : char == "W"
          ? always(-1)
          : never<String, int>();
});

final lat =
    zip3(string.double, string.prefix("° "), northSouthSign).map((tuple) {
  final (doubleValue, _, sign) = tuple;
  return doubleValue * sign;
});

final lng = zip3(string.double, string.prefix("° "), eastWestSign).map((tuple) {
  final (doubleValue, _, sign) = tuple;
  return doubleValue * sign;
});

// "15.832373° S, 47.987751° W"
final coord = zip3(lat, string.prefix(", "), lng).map((tuple) {
  final (lat, _, lng) = tuple;
  return Coordinate(lat, lng);
});
