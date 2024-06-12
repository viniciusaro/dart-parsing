part of 'parsing.dart';

Parser<A> always<A>(A value) {
  return Parser<A>((string) => (value, string));
}

Parser<A> never<A>() {
  return Parser<A>((string) => (null, string));
}

Parser<core.String> prefix({required core.String pattern, core.int group = 0}) {
  return Parser<core.String>((string) {
    final regex = core.RegExp(pattern);
    final match = regex.matchAsPrefix(string);
    final result = match?.group(group);
    final rest = string.substring(result?.length ?? 0, string.length);
    return (result, rest);
  });
}

Parser<core.String> prefixUpTo(core.String string) =>
    prefix(pattern: "(.*)$string", group: 1);

Parser<core.String> prefixThrough(core.String string) =>
    prefix(pattern: ".*$string");

Parser<core.String> literal(core.String literal) => prefix(pattern: literal);

final char = prefix(pattern: r'[a-z|A-Z]');
final int = prefix(pattern: r'\d+').map(core.int.parse);
final double = prefix(pattern: r'\d+([,|.]?\d)*')
    .map((string) => string.replaceAll(",", "."))
    .map(core.double.parse);

final zeroOrMoreSpaces = prefix(pattern: r' ').map((_) => unit);

final oneOrMoreSpaces = prefix(pattern: r' +')
    .flatMap((spaces) => spaces.isNotEmpty ? always(unit) : never<Unit>());
