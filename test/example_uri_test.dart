import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("episode parser", () {
    expect(
      episode.run(UriInput.parse("episodes/42")),
      (Episodes(id: 42), UriInput.empty()),
    );

    expect(
      episode.run(UriInput.parse("episodes/42?time=120")),
      (Episodes(id: 42, time: 120), UriInput.empty()),
    );

    expect(
      episode.run(UriInput.parse("episodes/42?speed=2x")),
      (Episodes(id: 42, speed: 2), UriInput.empty()),
    );

    expect(
      episode.run(UriInput.parse("episodes/42?time=120&speed=2x")),
      (Episodes(id: 42, time: 120, speed: 2), UriInput.empty()),
    );
  });

  test("episode comments", () {
    expect(
      episodeComments.run(UriInput.parse("episodes/42/comments")),
      (EpisodeComments(id: 42), UriInput.empty()),
    );
  });
}
