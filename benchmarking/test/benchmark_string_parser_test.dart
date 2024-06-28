import 'package:test/test.dart';
import 'package:benchmarking/parsers.dart';

void main() {
  test("string starts with", () {
    final parser = StringPrefix.literal("Brasília");

    for (var i = 0; i < 10; i++) {
      final (result, rest) = parser.run("Brasília$lipsum");
      expect(result, "Brasília");
      expect(rest, lipsum);
    }
  });
}
