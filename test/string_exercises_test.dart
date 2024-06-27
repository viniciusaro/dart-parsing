import 'dart:convert';

import 'package:test/test.dart';

void main() {
  const br = ["🇧", "🇷"];
  const zero = "0";
  const ten = "10";

  test("code units and runes", () {
    var string = "🇧🇷";
    final units = string.codeUnits;
    final runes = string.runes.toList();
    final bytes = utf8.encode(string);

    print("------------------");
    print("code units and runes - '$string'");

    print("units: $units");
    print(String.fromCharCodes(units));

    print("runes: $runes");
    print(String.fromCharCodes(runes));

    print("bytes: $bytes");
    print(utf8.decode(bytes));

    print("br: $br");
    print(String.fromCharCodes(br.expand((e) => e.runes.toList())));
  });

  test("zero", () {
    final units = zero.codeUnits;
    final runes = zero.runes.toList();
    final bytes = utf8.encode(zero);

    print("------------------");
    print("zero - '$zero'");

    print("units: $units");
    print(String.fromCharCodes(units));

    print("runes: $runes");
    print(String.fromCharCodes(runes));

    print("bytes: $bytes");
    print(utf8.decode(bytes));
  });

  test("ten", () {
    final units = ten.codeUnits;
    final runes = ten.runes.toList();
    final bytes = utf8.encode(ten);

    print("------------------");
    print("ten - '$ten'");

    print("units: $units");
    print(String.fromCharCodes(units));

    print("runes: $runes");
    print(String.fromCharCodes(runes));

    print("bytes: $bytes");
    print(utf8.decode(bytes));
  });

  test("runes to string", () {
    final naturalNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

    print("------------------");
    print("natural numbers - (runes, codeUnits, bytes)");

    print(
      naturalNumbers
          .map(
            (string) => (
              string,
              string.runes.toList(),
              string.codeUnits.toList(),
              utf8.encode(string)
            ),
          )
          .join("\n"),
    );
  });
}
