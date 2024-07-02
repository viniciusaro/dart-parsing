part of 'example.dart';

final northSouthSign = OneOf([
  StringLiteral("N").map((_) => 1),
  StringLiteral("S").map((_) => -1),
]);

final eastWestSign = OneOf([
  StringLiteral("E").map((_) => 1),
  StringLiteral("W").map((_) => -1),
]);

// "15.832373° S"
final lat = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(northSouthSign)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lng = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(eastWestSign)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coord = lat
    .skip(StringLiteral(","))
    .skip(StringLiteral(" "))
    .take(lng)
    .map(Coordinate.tuple);

final race = city
    .skip(StringLiteral(",\n"))
    .take(Many(coord, separator: StringLiteral(",\n"))) //
    .map(Race.tuple);

final races = //
    OneOrMore(race, separator: StringLiteral(",\n")) //
        .map(Races.new);
