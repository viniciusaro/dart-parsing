import 'dart:core' as core;
import 'parsing.dart' as parsing;

parsing.Parser<core.String, core.String> prefix(
  core.String pattern, [
  core.int group = 0,
]) {
  return parsing.prefix(
    pattern,
    (input, pattern) => core.RegExp(pattern).matchAsPrefix(input)?.group(group),
    (input, match) => input.substring(match.length, input.length),
  );
}

parsing.Parser<core.String, core.String> prefixUpTo(core.String string) =>
    prefix("(.*)$string", 1);

parsing.Parser<core.String, core.String> prefixThrough(core.String string) =>
    prefix(".*$string");

final int = prefix(r'\d+').map(core.int.parse);

final double = prefix(r'\d+([,|.]?\d)*')
    .map((string) => string.replaceAll(",", "."))
    .map(core.double.parse);

final char = prefix(r'[a-z|A-Z]');

final zeroOrMoreSpaces = prefix(r' ').map((_) => parsing.unit);

final oneOrMoreSpaces = prefix(r' +').flatMap((spaces) => spaces.isNotEmpty
    ? parsing.always(parsing.unit)
    : parsing.never<core.String, parsing.Unit>());
