part of 'parsing.dart';

class Many<Input, A> with Parser<Input, List<A>> {
  final Parser<Input, A> upstream;
  final Parser<Input, Unit>? separator;

  Many(this.upstream, {this.separator});

  @override
  (List<A>, Input) run(Input input) {
    var hasNext = true;
    var isFirst = true;
    var rest = input;
    final List<A> matches = [];

    while (hasNext) {
      try {
        if (!isFirst) {
          var separatorResult = separator?.run(rest).$2;
          rest = separatorResult ?? rest;
        }

        var (match, upstreamRest) = upstream.run(rest);
        rest = upstreamRest;
        matches.add(match);
      } catch (_) {
        hasNext = false;
      }
      isFirst = false;
    }
    return (matches, rest);
  }
}

class OneOrMore<Input, A> with Parser<Input, List<A>> {
  final Parser<Input, A> upstream;
  final Parser<Input, Unit>? separator;

  OneOrMore(this.upstream, {this.separator});

  @override
  Parser<Input, List<A>> body() {
    return upstream
        .skip(separator ?? Always(unit))
        .take(Many(upstream, separator: separator))
        .map((tuple) => tuple.$2 + [tuple.$1]);
  }
}
