part of 'parsing.dart';

class MapParser<Input, B> with Parser<Input, B> {
  final Parser<Input, dynamic> other;
  final B Function(dynamic) t;

  MapParser(this.other, this.t);

  @override
  (B, Input) run(Input input) {
    final (a, rest) = other.run(input);
    return (t(a), rest);
  }
}
