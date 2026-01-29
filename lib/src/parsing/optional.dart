part of 'parsing.dart';

class OptionalParser<A, Input> with Parser<A?, Input> {
  final Parser<A, Input> upstream;

  OptionalParser(this.upstream);

  @override
  (A?, Input) run(Input input) {
    try {
      return upstream.run(input);
    } catch (e) {
      return (null, input);
    }
  }
}
