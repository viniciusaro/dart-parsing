import 'parser.dart';

class Prefix<E> with Parser<Iterable<E>, Iterable<E>> {
  final bool Function(E) predicate;

  Prefix(this.predicate);

  @override
  (Iterable<E>, Iterable<E>) run(Iterable<E> input) {
    final result = input.takeWhile(predicate);
    final rest = input.skip(result.length);
    return (result, rest);
  }
}
