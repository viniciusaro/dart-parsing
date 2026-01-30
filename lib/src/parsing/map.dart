part of 'parsing.dart';

class MapParser<A, B, Input> with Parser<B, Input> {
  final Parser<A, Input> upstream;
  final B Function(A) t;

  MapParser(this.upstream, this.t);

  @override
  (B, Input) run(Input input) {
    final (a, rest) = upstream.run(input);
    return (t(a), rest);
  }
}
