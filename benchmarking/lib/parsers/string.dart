import 'package:parsing/parsing.dart';

class StringPrefix with Parser<String, String> {
  final bool Function(String) predicate;

  StringPrefix(this.predicate);

  factory StringPrefix.pattern(String pattern) {
    var accumulator = "";
    return StringPrefix((string) {
      accumulator += string;
      final regex = RegExp(accumulator);
      final result = regex.matchAsPrefix(pattern) != null;
      if (result == false) {
        accumulator = "";
      }
      return result;
    });
  }

  factory StringPrefix.literal(String literal, [String? id]) {
    var accumulator = "";
    final literalLength = literal.length;

    return StringPrefix((char) {
      accumulator += char;
      if (accumulator.length < literalLength) {
        return true;
      }
      final result = literal == accumulator;
      if (result == false) {
        accumulator = "";
      }
      return result;
    });
  }

  @override
  (String, String) run(String input) {
    final parser = Prefix<StringCollection, String>(predicate);
    final (result, rest) = parser.run(StringCollection(input));
    return (result.source, rest.source);
  }
}

class StringCollection
    implements RangeReplaceableCollection<StringCollection, String> {
  final String source;

  StringCollection(this.source);

  @override
  int get length => source.length;

  @override
  StringCollection removeFirst(int count) {
    // .substring is an expensive method, unfortunetly.
    return StringCollection(source.substring(count));
  }

  @override
  StringCollection prefix(bool Function(String) predicate) {
    var prefix = "";
    final length = source.length;

    for (var i = 0; i < length; i++) {
      final char = source[i];
      if (predicate(char)) {
        prefix += char;
      } else {
        return StringCollection(prefix);
      }
    }
    return StringCollection(prefix);
  }

  @override
  int get hashCode => source.hashCode;

  @override
  bool operator ==(Object other) => other is String ? source == other : false;

  @override
  String toString() => source.toString();
}
