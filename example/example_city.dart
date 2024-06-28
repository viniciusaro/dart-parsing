part of 'example.dart';

final city = OneOf([
  StringLiteral("BSB").map((_) => City.bsb),
  StringLiteral("NY").map((_) => City.ny),
  StringLiteral("AMS").map((_) => City.ams),
]);
