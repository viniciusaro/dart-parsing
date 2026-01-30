part of 'example.dart';

final northSouthSignSlice = OneOf([
  StringLiteralSlice("N").map((_) => 1),
  StringLiteralSlice("S").map((_) => -1),
]);

final eastWestSignSlice = OneOf([
  StringLiteralSlice("E").map((_) => 1),
  StringLiteralSlice("W").map((_) => -1),
]);

// "15.832373° S"
final latSlice = DoubleParserSlice()
    .skip(StringLiteralSlice("°"))
    .skip(StringLiteralSlice(" "))
    .take(northSouthSignSlice)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lngSlice = DoubleParserSlice()
    .skip(StringLiteralSlice("°"))
    .skip(StringLiteralSlice(" "))
    .take(eastWestSignSlice)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coordSlice = latSlice
    .skip(StringLiteralSlice(","))
    .skip(StringLiteralSlice(" "))
    .take(lngSlice)
    .map(Coordinate.tuple);

final raceSlice = citySlice
    .skip(StringLiteralSlice(",\n"))
    .take(Many(coordSlice, separator: StringLiteralSlice(",\n"))) //
    .map(Race.tuple);

final racesSlice = //
    OneOrMore(raceSlice, separator: StringLiteralSlice(",\n")) //
        .map(Races.new);
