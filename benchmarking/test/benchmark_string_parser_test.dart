import 'package:test/test.dart';
import 'package:benchmarking/parsers.dart';

void main() {
  test("string starts with", () {
    final (result, rest) = StringStartsWith("Brasília").run("Brasília/DF");
    expect(result, "Brasília");
    expect(rest, "/DF");
  });
}
