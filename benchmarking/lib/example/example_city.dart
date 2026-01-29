part of 'example.dart';

final city = OneOf([
  StringLiteral("Bras")
      .skip(StringLiteralNormalized("í"))
      .skip(StringLiteral("lia"))
      .map((_) => City.bsb),
  StringLiteral("New York").map((_) => City.ny),
  StringLiteral("Amsterdam").map((_) => City.ams),
]);

final cityCodeUnit = OneOf([
  StringLiteralCodeUnit("Bras")
      .skip(StringLiteralCodeUnitNormalized("í"))
      .skip(StringLiteralCodeUnit("lia"))
      .map((_) => City.bsb),
  StringLiteralCodeUnit("New York").map((_) => City.ny),
  StringLiteralCodeUnit("Amsterdam").map((_) => City.ams),
]);
