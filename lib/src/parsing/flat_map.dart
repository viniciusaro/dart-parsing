part of 'parsing.dart';

class FlatMapParser<Input, A, B> with Parser<Input, B> {
  final Parser<Input, A> upstream;
  final Parser<Input, B> Function(A) transform;

  FlatMapParser(this.upstream, this.transform);

  @override
  (B, Input) run(Input input) {
    final (upstreamResult, upstreamRest) = upstream.run(input);
    final parser = transform(upstreamResult);
    return parser.run(upstreamRest);
  }
}
