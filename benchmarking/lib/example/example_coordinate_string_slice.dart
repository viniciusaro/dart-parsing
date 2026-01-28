part of 'example.dart';

final northSouthSignStringSlice = OneOf([
  StringLiteralSlice("N").map((_) => 1),
  StringLiteralSlice("S").map((_) => -1),
]);

final eastWestSignStringSlice = OneOf([
  StringLiteralSlice("E").map((_) => 1),
  StringLiteralSlice("W").map((_) => -1),
]);

// "15.832373° S"
final latStringSlice = DoubleParserString()
    .skip(StringLiteralSlice("°"))
    .skip(StringLiteralSlice(" "))
    .take(northSouthSignStringSlice)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lngStringSlice = DoubleParserString()
    .skip(StringLiteralSlice("°"))
    .skip(StringLiteralSlice(" "))
    .take(eastWestSignStringSlice)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coordStringSlice = latStringSlice
    .skip(StringLiteralSlice(","))
    .skip(StringLiteralSlice(" "))
    .take(lngStringSlice)
    .map(Coordinate.tuple);

final raceStringSlice = cityStringSlice
    .skip(StringLiteralSlice(",\n"))
    .take(Many(coordStringSlice, separator: StringLiteralSlice(",\n"))) //
    .map(Race.tuple);

final racesStringSlice =
    OneOrMore(raceStringSlice, separator: StringLiteralSlice(",\n")) //
        .map(Races.new);
