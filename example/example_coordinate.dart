part of 'example.dart';

final northSouthSign = oneOf([
  string.prefix("N").map((_) => 1),
  string.prefix("S").map((_) => -1),
]);

final eastWestSign = oneOf([
  string.prefix("E").map((_) => 1),
  string.prefix("W").map((_) => -1),
]);

// "15.832373° S"
final lat = string.double.skip(string.prefix("°"))
    .skip(string.zeroOrMoreSpaces)
    .take2(northSouthSign)
    .map(multiplyTuple)
    .map(numToDouble);

// "47.987751° W"
final lng = string.double.skip(string.prefix("°"))
    .skip(string.zeroOrMoreSpaces)
    .take2(eastWestSign)
    .map(multiplyTuple)
    .map(numToDouble);

// "15.832373° S, 47.987751° W"
final coord = lat
    .skip(string.prefix(","))
    .skip(string.zeroOrMoreSpaces)
    .take2(lng)
    .map(Coordinate.tuple);
