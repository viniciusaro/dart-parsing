part of 'parsing.dart';

class OneOf<Input, A> with Parser<Input, A> {
  final List<Parser<Input, A>> upstreams;
  OneOf(this.upstreams);

  @override
  Parser<Input, A> body() {
    return OneOfLazy(upstreams.map((parser) => () => parser));
  }
}

class OneOfLazy<Input, A> with Parser<Input, A> {
  final Iterable<Parser<Input, A> Function()> lazyUpstreams;
  final Map<int, Parser<Input, A>> _upstreams = {};

  OneOfLazy(this.lazyUpstreams);

  @override
  (A, Input) run(Input input) {
    final List<ParserError> failures = [];
    for (var i = 0; i < lazyUpstreams.length; i++) {
      final parser = _upstreams[i] ??= lazyUpstreams.elementAt(i).call();
      try {
        return parser.run(input);
      } catch (e) {
        failures.add(ParserError.fromError(e));
      }
    }
    throw ParserError.fromMany(failures);
  }
}
