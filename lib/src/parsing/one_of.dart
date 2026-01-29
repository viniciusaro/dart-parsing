part of 'parsing.dart';

class OneOf<A, Input> with Parser<A, Input> {
  final List<Parser<A, Input>> upstreams;
  OneOf(this.upstreams);

  @override
  Parser<A, Input> body() {
    return OneOfLazy(upstreams.map((parser) => () => parser));
  }
}

class OneOfLazy<A, Input> with Parser<A, Input> {
  final Iterable<Parser<A, Input> Function()> lazyUpstreams;
  final Map<int, Parser<A, Input>> _upstreams = {};

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
