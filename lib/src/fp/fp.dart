import 'dart:core';

///
final unit = const Unit._();

class Unit {
  const Unit._();
}

///
extension FunctionPipe<A, B> on B Function(A) {
  C Function(A) pipe<C>(
    C Function(B) other,
  ) {
    return (a) => other(this(a));
  }
}

///
num multiply(num a, num b) => a * b;
num multiplyTuple((num, num) tuple) => tuple.$1 * tuple.$2;
Unit toUnit<A>(A value) => unit;
double numToDouble(num a) => a.toDouble();
int numToInt(num a) => a.toInt();
String numToString(num a) => a.toString();

///
extension IterableExtensionStartsWith<T> on Iterable<T> {
  bool startsWith(Iterable<T> prefix) {
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
