import 'package:parsing/parsing.dart';
import 'package:test/test.dart';
import 'dart:core' as core;

// "15.832373° S, 47.987751° W"
final class Coordinate {
  final core.double latitude;
  final core.double longitude;
  Coordinate(this.latitude, this.longitude);

  @core.override
  core.int get hashCode => latitude.hashCode ^ longitude.hashCode ^ 31;

  core.bool operator ==(core.Object other) {
    return other is Coordinate &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}

final northSouthSign = char.flatMap((char) {
  return char == "N"
      ? always(1)
      : char == "S"
          ? always(-1)
          : never<core.int>();
});

final eastWestSign = char.flatMap((char) {
  return char == "E"
      ? always(1)
      : char == "W"
          ? always(-1)
          : never<core.int>();
});

final lat = zip3(double, literal("° "), northSouthSign).map((tuple) {
  final (doubleValue, _, sign) = tuple;
  return doubleValue * sign;
});

final lng = zip3(double, literal("° "), eastWestSign).map((tuple) {
  final (doubleValue, _, sign) = tuple;
  return doubleValue * sign;
});

// "15.832373° S, 47.987751° W"
final coord = zip3(lat, literal(", "), lng).map((tuple) {
  final (lat, _, lng) = tuple;
  return Coordinate(lat, lng);
});

void main() {
  test("int parser", () {
    expect(int.run("1"), (1, ""));
    expect(int.run("111 2"), (111, " 2"));
    expect(int.run("a1"), (null, "a1"));
  });

  test("double parser", () {
    expect(double.run("1"), (1.0, ""));
    expect(double.run("1,1"), (1.1, ""));
    expect(double.run("1.1"), (1.1, ""));
    expect(double.run("1,"), (1.0, ","));
    expect(double.run("1."), (1.0, "."));
    expect(double.run("."), (null, "."));
    expect(double.run("a1"), (null, "a1"));
  });

  test("literal parser", () {
    expect(literal("a").run("abc"), ("a", "bc"));
    expect(literal("a").run("bcd"), (null, "bcd"));
    expect(literal("a").run("bacd"), (null, "bacd"));
  });

  test("one or more spaces parser", () {
    expect(oneOrMoreSpaces.run("   "), (unit, ""));
    expect(oneOrMoreSpaces.run(""), (null, ""));
  });

  test("char parser", () {
    expect(char.run("A"), ("A", ""));
    expect(char.run("a"), ("a", ""));
    expect(char.run("ab"), ("a", "b"));
    expect(char.run("1a"), (null, "1a"));
    expect(char.run(""), (null, ""));
  });

  test("north south parser", () {
    expect(northSouthSign.run("N"), (1, ""));
    expect(northSouthSign.run("S"), (-1, ""));
    expect(northSouthSign.run("A"), (null, "A"));
    expect(northSouthSign.run("AN"), (null, "AN"));
    expect(northSouthSign.run("AS"), (null, "AS"));
    expect(northSouthSign.run("n"), (null, "n"));
    expect(northSouthSign.run("s"), (null, "s"));
  });

  test("coord parser zip", () {
    expect(
      coord.run("15.832373° S, 47.987751° W"),
      (Coordinate(-15.832373, -47.987751), ""),
    );
  });

  test("prefix up to", () {
    expect(prefixUpTo("C").run("ABC"), ("AB", "C"));
  });

  test("prefix through", () {
    expect(prefixThrough("C").run("ABC"), ("ABC", ""));
  });
}
