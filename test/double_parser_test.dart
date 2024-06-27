import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("code units prefix", () {
    final parser = DoubleParserCodeUnitsPrefix();

    final (result1, rest1) = parser.run("42.1".codeUnits.collection);
    expect(result1, 42.1);
    expect(rest1.source, []);

    var (result2, rest2) = parser.run("42".codeUnits.collection);
    expect(result2, 42);
    expect(rest2.source, []);

    var (result3, rest3) = parser.run("42.".codeUnits.collection);
    expect(result3, 42);
    expect(rest3.source, []);
  });
}
