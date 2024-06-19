part of 'parsing.dart';

class OneOf<I, O> with Parser<I, O> {
  final List<Parser<I, O>> parsers;
  OneOf(this.parsers);

  @override
  (O, I) run(I input) {
    final List<ParserError> failures = [];
    for (final parser in parsers) {
      try {
        return parser.run(input);
      } catch (e) {
        failures.add(ParserError.fromError(e));
      }
    }
    throw ParserError.fromMany(failures);
  }
}
