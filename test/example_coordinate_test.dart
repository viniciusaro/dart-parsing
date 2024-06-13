import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("north south parser", () {
    expect(northSouthSign.run("N"), (1, ""));
    expect(northSouthSign.run("S"), (-1, ""));
    expect(northSouthSign.run("A"), (null, "A"));
    expect(northSouthSign.run("AN"), (null, "AN"));
    expect(northSouthSign.run("AS"), (null, "AS"));
    expect(northSouthSign.run("n"), (null, "n"));
    expect(northSouthSign.run("s"), (null, "s"));
  });

  test("coord parser zip", () {
    expect(
      coord.run("15.832373° S, 47.987751° W"),
      (Coordinate(-15.832373, -47.987751), ""),
    );
  });
}
