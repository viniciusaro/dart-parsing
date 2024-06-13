import 'package:test/test.dart';
import 'package:parsing/iterable.dart';

void main() {
  test("prefix int list", () {
    final (result, rest) = prefix([1]).run([1, 2, 3, 4]);
    expect(result, [1]);
    expect(rest, [2, 3, 4]);
  });
}
