part of 'parsing.dart';

extension IterableExtension<T> on core.Iterable<T> {
  core.bool startsWith(core.Iterable<T> prefix) {
    if (prefix.length > this.length) {
      return false;
    }
    for (var i = 0; i < prefix.length; i++) {
      if (prefix.elementAt(i) != this.elementAt(i)) {
        return false;
      }
    }
    return true;
  }
}

core.num multiply(core.num a, core.num b) {
  return a * b;
}

core.num multiplyTuple((core.num, core.num) tuple) {
  return tuple.$1 * tuple.$2;
}

core.double numToDouble(core.num a) => a.toDouble();
core.int numToInt(core.num a) => a.toInt();
core.String numToString(core.num a) => a.toString();
