part of 'example.dart';

final northSouthSignMixin = OneOf([
  StringPrefix("N").map((_) => 1),
  StringPrefix("S").map((_) => -1),
]);

final eastWestSignMixin = OneOf([
  StringPrefix("E").map((_) => 1),
  StringPrefix("W").map((_) => -1),
]);

// "15.832373° S"
final latMixin = DoubleParser()
    .skip(StringPrefix("°"))
    .skip(StringPrefix(" "))
    .take(northSouthSignMixin)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lngMixin = DoubleParser()
    .skip(StringPrefix("°"))
    .skip(StringPrefix(" "))
    .take(eastWestSignMixin)
    .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coordMixin = latMixin
    .skip(StringPrefix(","))
    .skip(StringPrefix(" "))
    .take(lngMixin)
    .map(Coordinate.tuple);
