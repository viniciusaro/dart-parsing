part of 'parsing.dart';

mixin RangeReplaceableCollection<Self, Element>
    implements Collection<Self, Element> {
  Self removeFirst(int count);

  @override
  int get hashCode {
    return iterable.hashCode;
  }

  @override
  String toString() => iterable.toString();

  @override
  bool operator ==(Object other) {
    return other is Collection<Self, Element>
        ? IterableEquality().equals(iterable, other.iterable)
        : other is Iterable<Element>
            ? IterableEquality().equals(iterable, other)
            : false;
  }
}

mixin Collection<Self, Element> {
  int get length;
  Iterable<Element> get iterable;
  Self prefix(bool Function(Element) predicate);
}

class IterableCollection<E>
    with RangeReplaceableCollection<IterableCollection<E>, E> {
  final Iterable<E> _source;

  IterableCollection(this._source);

  @override
  Iterable<E> get iterable => _source;

  @override
  int get length => _source.length;

  @override
  IterableCollection<E> prefix(bool Function(E p1) predicate) {
    return IterableCollection(_source.takeWhile(predicate));
  }

  @override
  IterableCollection<E> removeFirst(int count) {
    return IterableCollection(_source.skip(count));
  }
}

class StringCollection with RangeReplaceableCollection<StringCollection, int> {
  final Iterable<int> _source;
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
  Iterable<int> get iterable =>
      _source.skip(_startIndex).take(_endIndex - _startIndex + 1);

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
}

extension StringExtensions on String {
  StringCollection get collection => StringCollection(this);
}

extension IterableExtensions<E> on Iterable<E> {
  IterableCollection<E> get collection => IterableCollection(this);
}

extension IntegerIterableCollection on IterableCollection<int> {
  String get stringValue => String.fromCharCodes(_source);
}
