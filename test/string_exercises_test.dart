import 'package:test/test.dart';

void main() {
  const br = ["🇧", "🇷"];
  const zero = "0";
  const ten = "10";

  test("code units and runes", () {
    var string = "🇧🇷";
    final units = string.codeUnits;
    final runes = string.runes.toList();

    print(units);
    print(String.fromCharCodes(units));

    print(runes);
    print(String.fromCharCodes(runes));

    print(br);
    print(String.fromCharCodes(br.expand((e) => e.runes.toList())));
  });

  test("zero", () {
    final units = zero.codeUnits;
    final runes = zero.runes.toList();

    print(units);
    print(String.fromCharCodes(units));

    print(runes);
    print(String.fromCharCodes(runes));
  });

  test("ten", () {
    final units = ten.codeUnits;
    final runes = ten.runes.toList();

    print(units);
    print(String.fromCharCodes(units));

    print(runes);
    print(String.fromCharCodes(runes));
  });

  test("runes to string", () {
    final naturalNumbers = [
      Runes("0"),
      Runes("1"),
      Runes("2"),
      Runes("3"),
      Runes("4"),
      Runes("5"),
      Runes("6"),
      Runes("7"),
      Runes("8"),
      Runes("9"),
    ];

    print(
      naturalNumbers.map((rune) => (rune.string, rune.toList())).join("\n"),
    );
  });
}
