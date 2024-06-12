import 'dart:core' as core;
import 'package:parsing/string.dart' as string;
import 'package:parsing/iterable.dart' as iterable;
import 'package:parsing/parsing.dart' as parsing;
import 'package:test/test.dart';

import 'parsers_coordinate.dart';

void main() {
  test("prefix int list", () {
    final (result, rest) = iterable.prefix([1]).run([1, 2, 3, 4]);
    expect(result, [1]);
    expect(rest, [2, 3, 4]);
  });

  test("prefix string", () {
    final (result, rest) = string.prefix("a").run("abc");
    expect(result, "a");
    expect(rest, "bc");
  });

  test("int parser", () {
    expect(string.int.run("1"), (1, ""));
    expect(string.int.run("111 2"), (111, " 2"));
    expect(string.int.run("a1"), (null, "a1"));
  });

  test("double parser", () {
    expect(string.double.run("1"), (1.0, ""));
    expect(string.double.run("1,1"), (1.1, ""));
    expect(string.double.run("1.1"), (1.1, ""));
    expect(string.double.run("1,"), (1.0, ","));
    expect(string.double.run("1."), (1.0, "."));
    expect(string.double.run("."), (null, "."));
    expect(string.double.run("a1"), (null, "a1"));
  });

  test("one or more spaces parser", () {
    expect(string.oneOrMoreSpaces.run("   "), (parsing.unit, ""));
    expect(string.oneOrMoreSpaces.run(""), (null, ""));
  });

  test("char parser", () {
    expect(string.char.run("A"), ("A", ""));
    expect(string.char.run("a"), ("a", ""));
    expect(string.char.run("ab"), ("a", "b"));
    expect(string.char.run("1a"), (null, "1a"));
    expect(string.char.run(""), (null, ""));
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
    expect(string.prefixUpTo("C").run("ABC"), ("AB", "C"));
  });

  test("prefix through", () {
    expect(string.prefixThrough("C").run("ABC"), ("ABC", ""));
  });
}
