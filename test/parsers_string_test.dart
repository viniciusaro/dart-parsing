import 'package:parsing/fp.dart';
import 'package:parsing/string.dart';
import 'package:test/test.dart';

void main() {
  test("prefix", () {
    expect(prefix("a").run("abc"), ("a", "bc"));
  });

  test("prefix up to", () {
    expect(prefixUpTo("C").run("ABC"), ("AB", "C"));
  });

  test("prefix through", () {
    expect(prefixThrough("C").run("ABC"), ("ABC", ""));
  });

  test("int", () {
    expect(int.run("1"), (1, ""));
    expect(int.run("111 2"), (111, " 2"));
    expect(int.run("a1"), (null, "a1"));
  });

  test("double", () {
    expect(double.run("1"), (1.0, ""));
    expect(double.run("1,1"), (1.1, ""));
    expect(double.run("1.1"), (1.1, ""));
    expect(double.run("1,"), (1.0, ","));
    expect(double.run("1."), (1.0, "."));
    expect(double.run("."), (null, "."));
    expect(double.run("a1"), (null, "a1"));
  });

  test("one or more spaces", () {
    expect(oneOrMoreSpaces.run("   "), (unit, ""));
    expect(oneOrMoreSpaces.run(""), (null, ""));
  });

  test("char", () {
    expect(char.run("A"), ("A", ""));
    expect(char.run("a"), ("a", ""));
    expect(char.run("ab"), ("a", "b"));
    expect(char.run("1a"), (null, "1a"));
    expect(char.run(""), (null, ""));
  });
}
