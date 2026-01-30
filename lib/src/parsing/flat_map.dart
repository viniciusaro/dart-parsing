part of 'parsing.dart';

class FlatMapParser<A, B, Input> with Parser<B, Input> {
  final Parser<A, Input> upstream;
  final Parser<B, Input> Function(A) transform;

  FlatMapParser(this.upstream, this.transform);

  @override
  (B, Input) run(Input input) {
    final (upstreamResult, upstreamRest) = upstream.run(input);
    final parser = transform(upstreamResult);
    return parser.run(upstreamRest);
  }
}
