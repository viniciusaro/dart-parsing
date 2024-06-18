import 'package:parsing/fp.dart';
import 'package:parsing/parsing.dart';
import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("episode parser", () {
    expect(
      router.run(Some(Uri.parse("episodes/42"))),
      (Episodes(id: 42), None<Uri>()),
    );

    expect(
      router.run(Some(Uri.parse("episodes/42?time=120"))),
      (Episodes(id: 42, time: 120), None<Uri>()),
    );

    expect(
      router.run(Some(Uri.parse("episodes/42?speed=2x"))),
      (Episodes(id: 42, speed: 2), None<Uri>()),
    );

    expect(
      router.run(Some(Uri.parse("episodes/42?time=120&speed=2x"))),
      (Episodes(id: 42, time: 120, speed: 2), None<Uri>()),
    );
  });

  test("episode comments", () {
    expect(
      routerMixin.run(Some(Uri.parse("episodes/42?time=120&speed=2"))),
      (Episodes(id: 42, time: 120, speed: 2), None<Uri>()),
    );

    expect(
      routerMixin.run(Some(Uri.parse("episodes/42/comments"))),
      (EpisodeComments(id: 42), None<Uri>()),
    );
  });
}
