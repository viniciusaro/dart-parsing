part of 'example.dart';

final city = OneOf([
  StringLiteral("Bras")
      .skip(StringLiteralNormalized("í"))
      .skip(StringLiteral("lia"))
      .map((_) => City.bsb),
  StringLiteral("New York").map((_) => City.ny),
  StringLiteral("Amsterdam").map((_) => City.ams),
]);

final citySlice = OneOf([
  StringLiteralSlice("Bras")
      .skip(StringLiteralSliceNormalized("í"))
      .skip(StringLiteralSlice("lia"))
      .map((_) => City.bsb),
  StringLiteralSlice("New York").map((_) => City.ny),
  StringLiteralSlice("Amsterdam").map((_) => City.ams),
]);
