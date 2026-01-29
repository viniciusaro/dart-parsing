part of '../parsing.dart';

final class StringSlice {
  final String _source;
  final int _startIndex;
  final int _endIndex;

  int get length => _endIndex - _startIndex + 1;

  StringSlice(this._source)
      : this._startIndex = 0,
        this._endIndex = _source.length - 1;

  StringSlice._(
    this._source,
    this._startIndex,
    this._endIndex,
  );

  Iterable<int> get iterable sync* {
    for (int i = _startIndex; i <= _endIndex; i++) {
      yield _source.codeUnitAt(i);
    }
  }

  bool startsWith(StringSlice other) {
    if (other.length > this.length) {
      return false;
    }
    if (other == this) {
      return true;
    }

    for (int i = _startIndex, j = other._startIndex;
        j < other.length;
        i++, j++) {
      if (other._source.codeUnitAt(j) != _source.codeUnitAt(i)) {
        return false;
      }
    }
    return true;
  }

  StringSlice prefix(int count) {
    return StringSlice._(_source, _startIndex, _endIndex - (length - count));
  }

  StringSlice removeFirst(int count) {
    return StringSlice._(_source, _startIndex + count, _endIndex);
  }

  @override
  String toString() {
    return _source.substring(_startIndex, _endIndex + 1);
  }

  @override
  operator ==(Object other) {
    return other is StringSlice &&
        other._source == _source &&
        other._startIndex == _startIndex &&
        other._endIndex == _endIndex;
  }
}

extension StringExtensions on String {
  StringSlice get slice => StringSlice(this);
}
