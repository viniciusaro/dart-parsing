part of 'parsing.dart';

class ParserError {
  final String expected;
  final dynamic remainingInput;

  ParserError({required this.expected, required this.remainingInput});

  factory ParserError.fromMany(List<ParserError> errors) {
    return ParserError(
      expected: errors.map((error) => error.expected).join(" "),
      remainingInput: errors.map((error) => error.remainingInput).join(" "),
    );
  }

  static ParserError fromError(dynamic error) {
    return error is ParserError
        ? error
        : ParserError(
            expected: error,
            remainingInput: "",
          );
  }

  @override
  String toString() {
    return """
    Parser Error:
    expected: ${expected.length > 50 ? expected.substring(0, 50) + "..." : expected}
    remaining: $remainingInput
    """;
  }
}
