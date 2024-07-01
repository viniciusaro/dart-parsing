import 'dart:convert';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

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

  test("e acute", () {
    const eAcute0 = "é"; // String.fromCharCodes([0x00E9]);
    const eAcute1 = "é"; // String.fromCharCodes([0x0065, 0x0301]);
    final normalized0 = unorm.nfc(eAcute0);
    final normalized1 = unorm.nfc(eAcute1);

    print(eAcute0);
    print(eAcute0.codeUnits);
    print(normalized0.codeUnits);
    print("---");
    print(eAcute1);
    print(eAcute1.codeUnits);
    print(normalized1.codeUnits);

    expect("a" == "a", isTrue);
    expect(eAcute0 != eAcute1, isTrue);
    expect(eAcute0.codeUnits != eAcute1.codeUnits, isTrue);
    expect(normalized0 == normalized1, isTrue);
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
