part of 'parsing.dart';

class OneOrMore<A, Input> with Parser<List<A>, Input> {
  final Parser<A, Input> upstream;
  final Parser<Unit, Input>? separator;

  OneOrMore(this.upstream, {Parser<dynamic, Input>? separator})
      : separator = separator?.map(toUnit);

  @override
  Parser<List<A>, Input> body() {
    return upstream
        .skip(OptionalParser(separator ?? Always(unit)))
        .take(Many(upstream, separator: separator))
        .map((tuple) => [tuple.$1] + tuple.$2);
  }
}
