part of 'parsing.dart';

class StringPrefix with Parser<String, String> {
  final bool Function(String)? predicate;

  StringPrefix([this.predicate]);

  factory StringPrefix.pattern(String pattern) {
    return StringPrefix((string) {
      final regex = RegExp(pattern);
      return regex.matchAsPrefix(string) != null;
    });
  }

  factory StringPrefix.literal(String literal) {
    return StringPrefix.pattern(literal);
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
    return StringCollection(source.substring(count));
  }

  @override
  StringCollection prefix(bool Function(String) predicate) {
    var prefix = "";

    for (var i = 0; i < source.length; i++) {
      final candidate = source[i];
      if (predicate(candidate)) {
        prefix += candidate;
      } else {
        break;
      }
    }
    return StringCollection(prefix);
  }
}
