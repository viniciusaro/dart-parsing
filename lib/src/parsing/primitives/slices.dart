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
    return false;
  }

  StringSlice removeFirst(int count) {
    return StringSlice._(_source, _startIndex + count, _endIndex);
  }
}
