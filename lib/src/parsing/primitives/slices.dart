part of '../parsing.dart';

final class MutableStringSlice {
  final String _source;
  int _startIndex;
  int _endIndex;

  int get length => _endIndex - _startIndex + 1;

  MutableStringSlice(this._source)
      : this._startIndex = 0,
        this._endIndex = _source.length - 1;

  MutableStringSlice._(
    this._source,
    this._startIndex,
    this._endIndex,
  );

  int codeUnitAt(int i) => _source.codeUnitAt(_startIndex + i);

  bool startsWith(MutableStringSlice other) {
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

  void take(int count) {
    _endIndex = _endIndex - (length - count);
  }

  void skip(int count) {
    _startIndex = _startIndex + count;
  }

  MutableStringSlice taking(int count) {
    return MutableStringSlice._(
        _source, _startIndex, _endIndex - (length - count));
  }

  MutableStringSlice skiping(int count) {
    return MutableStringSlice._(_source, _startIndex + count, _endIndex);
  }

  @override
  String toString() {
    return _source.substring(_startIndex, _endIndex + 1);
  }

  @override
  operator ==(Object other) {
    return other is MutableStringSlice &&
        other._source == _source &&
        other._startIndex == _startIndex &&
        other._endIndex == _endIndex;
  }
}
