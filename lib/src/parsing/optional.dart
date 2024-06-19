part of 'parsing.dart';

class OptionalParser<Input, A> with Parser<Input, A?> {
  final Parser<Input, A> upstream;

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
