import 'package:benchmarking/example/example.dart';
import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("parsers individual cities", () {
    expect(city.run("Brasília".codeUnits.collection).$1, City.bsb);
    expect(city.run("New York".codeUnits.collection).$1, City.ny);
    expect(city.run("Amsterdam".codeUnits.collection).$1, City.ams);
  });

  test("parses acute", () {
    final iAcute0 = "í"; //String.fromCharCodes([0x00ED]);
    final iAcute1 = "í"; //String.fromCharCodes([0x0069, 0x0301]);

    final (result0, rest0) = city.run("Bras${iAcute0}lia".codeUnits.collection);
    expect(result0, City.bsb);
    expect(rest0.source, []);

    final (result1, rest1) = city.run("Bras${iAcute1}lia".codeUnits.collection);
    expect(result1, City.bsb);
    expect(rest1.source, []);
  });
}
