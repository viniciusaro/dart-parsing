import 'package:benchmarking/example/example.dart';
import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("parsers individual cities", () {
    expect(city.run("Brasília".slice).$1, City.bsb);
    expect(city.run("New York".slice).$1, City.ny);
    expect(city.run("Amsterdam".slice).$1, City.ams);
  });

  test("parses acute", () {
    final iAcute0 = "í"; //String.fromCharCodes([0x00ED]);
    final iAcute1 = "í"; //String.fromCharCodes([0x0069, 0x0301]);

    final (result0, rest0) = city.run("Bras${iAcute0}lia".slice);
    expect(result0, City.bsb);
    expect(rest0.toString(), "");

    final (result1, rest1) = city.run("Bras${iAcute1}lia".slice);
    expect(result1, City.bsb);
    expect(rest1.toString(), "");
  });
}
