part of 'parsing.dart';

class Prefix<C extends RangeReplaceableCollection<C, E>, E> with Parser<C, C> {
  final bool Function(E)? predicate;

  Prefix([this.predicate]);

  @override
  (C, C) run(C input) {
    final match = predicate != null ? input.prefix(predicate!) : input;
    final rest = input.removeFirst(match.length);
    return (match, rest);
  }
}

mixin RangeReplaceableCollection<Self, Element> on Collection<Self, Element> {
  Self removeFirst(int count);
}

mixin Collection<Self, Element> {
  int get length;
  Self prefix(bool Function(Element) predicate);
}

typedef IterableCollectionPrefix<E> = Prefix<IterableCollection<E>, E>;
