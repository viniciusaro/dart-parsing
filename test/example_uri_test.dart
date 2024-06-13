import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test("episode parser", () {
    expect(
      episode.run(RequestInput.uri("episodes/42")),
      (Episodes(id: 42), RequestInput.empty()),
    );

    expect(
      episode.run(RequestInput.uri("episodes/42?time=120")),
      (Episodes(id: 42, time: 120), RequestInput.empty()),
    );

    expect(
      episode.run(RequestInput.uri("episodes/42?speed=2x")),
      (Episodes(id: 42, speed: 2), RequestInput.empty()),
    );

    expect(
      episode.run(RequestInput.uri("episodes/42?time=120&speed=2x")),
      (Episodes(id: 42, time: 120, speed: 2), RequestInput.empty()),
    );
  });

  test("episode comments", () {
    expect(
      episodeComments.run(RequestInput.uri("episodes/42/comments")),
      (EpisodeComments(id: 42), RequestInput.empty()),
    );
  });
}
