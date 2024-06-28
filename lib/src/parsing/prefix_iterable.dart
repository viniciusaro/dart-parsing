part of 'parsing.dart';

class IterableCollection<E>
    implements RangeReplaceableCollection<IterableCollection<E>, E> {
  final Iterable<E> source;

  IterableCollection(this.source);

  @override
  int get length => source.length;

  @override
  IterableCollection<E> prefix(bool Function(E p1) predicate) {
    return IterableCollection(source.takeWhile(predicate));
  }

  @override
  IterableCollection<E> removeFirst(int count) {
    return IterableCollection(source.skip(count));
  }

  @override
  int get hashCode => source.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Iterable<E> ? IterableEquality().equals(source, other) : false;

  @override
  String toString() => source.toString();
}

extension IntegerIterableCollection on IterableCollection<int> {
  String get stringValue => String.fromCharCodes(source);
}

extension IterableExtensions<E> on Iterable<E> {
  IterableCollection<E> get collection => IterableCollection(this);
}
