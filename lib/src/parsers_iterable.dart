import 'dart:core' as core;
import 'package:parsing/fp.dart';

import 'parsing.dart' as parsing;

parsing.Parser<core.Iterable<E>, core.Iterable<E>> prefix<E>(
  core.Iterable<E> candidate,
) {
  return parsing.prefix(
    candidate,
    (input, candidate) => input.startsWith(candidate) ? candidate : null,
    (input, match) => input.skip(match.length),
  );
}
