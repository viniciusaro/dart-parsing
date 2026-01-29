part of 'example.dart';

final northSouthSignCodeUnit = OneOf([
  StringLiteralCodeUnit("N").map((_) => 1),
  StringLiteralCodeUnit("S").map((_) => -1),
]);

final eastWestSignCodeUnit = OneOf([
  StringLiteralCodeUnit("E").map((_) => 1),
  StringLiteralCodeUnit("W").map((_) => -1),
]);

// "15.832373° S"
final latCodeUnit = DoubleParserCodeUnit()
    .skip(StringLiteralCodeUnit("°"))
    .skip(StringLiteralCodeUnit(" "))
    .take(northSouthSignCodeUnit)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lngCodeUnit = DoubleParserCodeUnit()
    .skip(StringLiteralCodeUnit("°"))
    .skip(StringLiteralCodeUnit(" "))
    .take(eastWestSignCodeUnit)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coordCodeUnit = latCodeUnit
    .skip(StringLiteralCodeUnit(","))
    .skip(StringLiteralCodeUnit(" "))
    .take(lngCodeUnit)
    .map(Coordinate.tuple);

final raceCodeUnit = cityCodeUnit
    .skip(StringLiteralCodeUnit(",\n"))
    .take(Many(coordCodeUnit, separator: StringLiteralCodeUnit(",\n"))) //
    .map(Race.tuple);

final racesCodeUnit = //
    OneOrMore(raceCodeUnit, separator: StringLiteralCodeUnit(",\n")) //
        .map(Races.new);
