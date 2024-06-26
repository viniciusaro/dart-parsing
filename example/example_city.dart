part of 'example.dart';

final city = OneOf([
  StringPrefix("BSB").map((_) => City.bsb),
  StringPrefix("NY").map((_) => City.ny),
  StringPrefix("AMS").map((_) => City.ams),
]);
