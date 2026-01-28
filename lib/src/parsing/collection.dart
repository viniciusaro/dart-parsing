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

class StringSlice with RangeReplaceableCollection<StringSlice, int> {
  final String _source;
  final int _startIndex;
  final int _endIndex;

  StringSlice(String source)
      : _source = source,
        _startIndex = 0,
        _endIndex = source.length;

  StringSlice._(String source, int startIndex, int endIndex)
      : _source = source,
        _startIndex = startIndex,
        _endIndex = endIndex;

  @override
  Iterable<int> get iterable sync* {
    for (var i = 0; i < length; i++) {
      yield _source.codeUnitAt(_startIndex + i);
    }
  }

  @override
  int get length => _endIndex - _startIndex;

  @override
  StringSlice prefix(bool Function(int p1) predicate) {
    for (var i = _startIndex; i < _endIndex; i++) {
      if (!predicate(_source.codeUnitAt(i))) {
        return i == 0 ? this : StringSlice._(_source, _startIndex, i - 1);
      }
    }
    return this;
  }

  @override
  StringSlice removeFirst(int count) {
    return StringSlice._(_source, _startIndex + count, _endIndex);
  }

  bool startsWith(StringSlice other) {
    if (other == this) {
      return true;
    }

    if (other.length > length) {
      return false;
    }

    var i = _startIndex;
    for (int element in other.iterable) {
      if (_source.codeUnitAt(i) != element) {
        return false;
      }
      i++;
    }
    return true;
  }

  @override
  String toString() {
    return _source.substring(_startIndex, _endIndex);
  }

  @override
  bool operator ==(Object other) {
    return other is StringSlice &&
        other._source == _source &&
        other._startIndex == _startIndex &&
        other._endIndex == _endIndex;
  }
}

extension StringExtensions on String {
  StringSlice get slice => StringSlice(this);
}

extension IterableExtensions<E> on Iterable<E> {
  IterableCollection<E> get collection => IterableCollection(this);
}

extension IntegerIterableCollection on IterableCollection<int> {
  String get stringValue => String.fromCharCodes(_source);
}
