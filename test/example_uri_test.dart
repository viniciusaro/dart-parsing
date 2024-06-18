import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("episode parser", () {
    expect(
      router.run(Uri.parse("episodes/42")),
      (Episodes(id: 42), null),
    );

    expect(
      router.run(Uri.parse("episodes/42?time=120")),
      (Episodes(id: 42, time: 120), null),
    );

    expect(
      router.run(Uri.parse("episodes/42?speed=2x")),
      (Episodes(id: 42, speed: 2), null),
    );

    expect(
      router.run(Uri.parse("episodes/42?time=120&speed=2x")),
      (Episodes(id: 42, time: 120, speed: 2), null),
    );
  });

  test("episode comments", () {
    expect(
      routerMixin.run(Uri.parse("episodes/42?time=120&speed=2x")),
      (Episodes(id: 42, time: 120, speed: 2), null),
    );

    expect(
      routerMixin.run(Uri.parse("episodes/42/comments")),
      (EpisodeComments(id: 42), null),
    );
  });
}
