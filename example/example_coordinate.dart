part of 'example.dart';

final northSouthSign = OneOf([
  // StringPrefix("N").map((_) => 1),
  // StringPrefix("S").map((_) => -1),
]);

final eastWestSign = OneOf([
  // StringPrefix("E").map((_) => 1),
  // StringPrefix("W").map((_) => -1),
]);

// "15.832373° S"
final lat = DoubleParser();
// .skip(StringPrefix("°"))
// .skip(StringPrefix(" "))
// .take(northSouthSign)
// .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lng = DoubleParser();
// .skip(StringPrefix("°"))
// .skip(StringPrefix(" "))
// .take(eastWestSign)
// .map(multiplyTuple.pipe(numToDouble));

// "15.832373° S, 47.987751° W"
final coord = lat;
    // .skip(StringPrefix(","))
    // .skip(StringPrefix(" "))
    // .take(lng)
    // .map(Coordinate.tuple);
