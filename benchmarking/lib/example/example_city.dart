part of 'example.dart';

final city = OneOf([
  StringLiteral("Bras")
      .skip(StringLiteralNormalized("í"))
      .skip(StringLiteral("lia"))
      .map((_) => City.bsb),
  StringLiteral("New York").map((_) => City.ny),
  StringLiteral("Amsterdam").map((_) => City.ams),
]);

final cityString = OneOf([
  StringLiteralString("Bras")
      .skip(StringLiteralNormalizedString("í"))
      .skip(StringLiteralString("lia"))
      .map((_) => City.bsb),
  StringLiteralString("New York").map((_) => City.ny),
  StringLiteralString("Amsterdam").map((_) => City.ams),
]);
