part of 'parsing.dart';

class OneOrMore<Input, A> with Parser<Input, List<A>> {
  final Parser<Input, A> upstream;
  final Parser<Input, Unit>? separator;

  OneOrMore(this.upstream, {this.separator});

  @override
  Parser<Input, List<A>> body() {
    return upstream
        .skip(OptionalParser(separator ?? Always(unit)))
        .take(Many(upstream, separator: separator))
        .map((tuple) => [tuple.$1] + tuple.$2);
  }
}
