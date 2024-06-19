part of 'parsing.dart';

class StringPrefix with Parser<String, String> {
  final String prefix;
  final int group;

  StringPrefix(this.prefix, [this.group = 0]);

  @override
  (String, String) run(String input) {
    final regex = RegExp(prefix);
    final match = regex.matchAsPrefix(input);
    final group = match?.group(this.group);
    if (group == null) {
      throw ParserError(expected: prefix, remainingInput: input);
    }
    final rest = input.substring(group.length, input.length);
    return (group, rest);
  }
}
