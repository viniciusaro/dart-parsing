import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

void main() {
  test("code units prefix", () {
    final parser = DoubleParser();

    final (result1, rest1) = parser.run("42.1".slice);
    expect(result1, 42.1);
    expect(rest1.toString(), "");

    var (result2, rest2) = parser.run("42".slice);
    expect(result2, 42);
    expect(rest2.toString(), "");

    var (result3, rest3) = parser.run("42.".slice);
    expect(result3, 42);
    expect(rest3.toString(), "");
  });
}
