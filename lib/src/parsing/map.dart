part of 'parsing.dart';

class MapParser<Input, A, B> with Parser<Input, B> {
  final Parser<Input, A> upstream;
  final B Function(A) t;

  MapParser(this.upstream, this.t);

  @override
  (B, Input) run(Input input) {
    final (a, rest) = upstream.run(input);
    return (t(a), rest);
  }
}
