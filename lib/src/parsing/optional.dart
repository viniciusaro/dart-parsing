part of 'parsing.dart';

class OptionalParser<I, O> with Parser<I, O?> {
  final Parser<I, O> other;

  OptionalParser(this.other);

  @override
  (O?, I) run(I input) {
    try {
      return other.run(input);
    } catch (e) {
      return (null, input);
    }
  }
}
