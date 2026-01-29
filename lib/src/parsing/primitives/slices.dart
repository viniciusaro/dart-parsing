part of '../parsing.dart';

final class StringSlice {
  final String _source;
  final int _startIndex;
  final int _endIndex;

  int get length => _endIndex - _startIndex;

  StringSlice(this._source)
      : this._startIndex = 0,
        this._endIndex = _source.length;

  StringSlice._(
    this._source,
    this._startIndex,
    this._endIndex,
  );

  Iterable<int> get iterable sync* {
    for (var i = 0; i < length; i++) {
      yield _source.codeUnitAt(_startIndex + i);
    }
  }

  bool startsWith(StringSlice other) {
    if (other.length > this.length) {
      return false;
    }
    if (other == this) {
      return true;
    }

    int i = _startIndex;
    for (final unit in other.iterable) {
      if (unit != _source.codeUnitAt(i)) {
        return false;
      }
      i++;
    }
    return true;
  }

  StringSlice removeFirst(int count) {
    return StringSlice._(_source, _startIndex + count, _endIndex);
  }

  @override
  String toString() {
    return _source.substring(_startIndex, _endIndex);
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
