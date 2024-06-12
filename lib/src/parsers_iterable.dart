import 'dart:core' as core;
import 'parsing.dart' as parsing;
import 'package:fpdart/fpdart.dart';

parsing.Parser<core.Iterable<E>, core.Iterable<E>> prefix<E>(
  core.Iterable<E> candidate,
) {
  return parsing.prefix(
    candidate,
    (input, candidate) => input.startsWith(candidate) ? candidate : null,
    (input, match) => input.drop(match.length),
  );
}
