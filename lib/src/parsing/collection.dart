part of 'parsing.dart';

mixin RangeReplaceableCollection<Self, Element> on Collection<Self, Element> {
  Self removeFirst(int count);
}

mixin Collection<Self, Element> {
  int get length;
  Self prefix(bool Function(Element) predicate);
}

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

class StringCollection
    implements RangeReplaceableCollection<StringCollection, int> {
  final Iterable<int> _source;
  Iterable<int> get source => _source.skip(_startIndex).take(_endIndex + 1);

  final int _startIndex;
  final int _endIndex;

  StringCollection(String source)
      : _source = source.codeUnits,
        _startIndex = 0,
        _endIndex = source.length - 1;

  StringCollection._(Iterable<int> source, int startIndex, int endIndex)
      : _source = source,
        _startIndex = startIndex,
        _endIndex = endIndex;

  @override
  int get length => _endIndex - _startIndex + 1;

  @override
  StringCollection prefix(bool Function(int p1) predicate) {
    for (var i = _startIndex; i <= _endIndex; i++) {
      if (!predicate(_source.elementAt(i))) {
        return i == 0 ? this : StringCollection._(_source, _startIndex, i - 1);
      }
    }
    return this;
  }

  @override
  StringCollection removeFirst(int count) {
    return StringCollection._(_source, _startIndex + count, _endIndex);
  }

  @override
  int get hashCode => source.hashCode;

  @override
  bool operator ==(Object other) {
    return other is StringCollection &&
        IterableEquality().equals(source, other.source);
  }
}

extension StringExtensions on String {
  StringCollection get collection => StringCollection(this);
}

extension IterableExtensions<E> on Iterable<E> {
  IterableCollection<E> get collection => IterableCollection(this);
}

extension IntegerIterableCollection on IterableCollection<int> {
  String get stringValue => String.fromCharCodes(source);
}
