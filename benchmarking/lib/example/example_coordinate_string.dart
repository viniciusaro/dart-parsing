part of 'example.dart';

final northSouthSignString = OneOf([
  StringLiteralString("N").map((_) => 1),
  StringLiteralString("S").map((_) => -1),
]);

final eastWestSignString = OneOf([
  StringLiteralString("E").map((_) => 1),
  StringLiteralString("W").map((_) => -1),
]);

// "15.832373° S"
final latString = DoubleParserString()
    .skip(StringLiteralString("°"))
    .skip(StringLiteralString(" "))
    .take(northSouthSignString)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lngString = DoubleParserString()
    .skip(StringLiteralString("°"))
    .skip(StringLiteralString(" "))
    .take(eastWestSignString)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coordString = latString
    .skip(StringLiteralString(","))
    .skip(StringLiteralString(" "))
    .take(lngString)
    .map(Coordinate.tuple);

final raceString = cityString
    .skip(StringLiteralString(",\n"))
    .take(Many(coordString, separator: StringLiteralString(",\n"))) //
    .map(Race.tuple);

final racesString =
    OneOrMore(raceString, separator: StringLiteralString(",\n")) //
        .map(Races.new);
