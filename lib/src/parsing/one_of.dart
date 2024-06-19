part of 'parsing.dart';

class OneOf<Input, A> with Parser<Input, A> {
  final List<Parser<Input, A>> upstreams;
  OneOf(this.upstreams);

  @override
  (A, Input) run(Input input) {
    final List<ParserError> failures = [];
    for (final parser in upstreams) {
      try {
        return parser.run(input);
      } catch (e) {
        failures.add(ParserError.fromError(e));
      }
    }
    throw ParserError.fromMany(failures);
  }
}
