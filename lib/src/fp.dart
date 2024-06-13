import 'dart:core';

final unit = const Unit._();

class Unit {
  const Unit._();
}

sealed class Optional<A> {
  static Some<A> some<A>(A value) => Some<A>(value: value);
  static None<A> none<A>() => None<A>();

  A? get optional {
    final self = this;
    switch (self) {
      case Some<A>():
        return self.value;
      case None<A>():
        return null;
    }
  }
}

class Some<A> extends Optional<A> {
  final A value;
  Some({required this.value});
}

class None<A> extends Optional<A> {}

C Function(A) pipe<A, B, C>(
  B Function(A) f,
  C Function(B) g,
) {
  return (a) => g(f(a));
}

D Function(A) pipe3<A, B, C, D>(
  B Function(A) f,
  C Function(B) g,
  D Function(C) h,
) {
  return (a) => h(g(f(a)));
}

num multiply(num a, num b) {
  return a * b;
}

Unit toUnit<A>(A value) => unit;

num multiplyTuple((num, num) tuple) {
  return tuple.$1 * tuple.$2;
}

double numToDouble(num a) => a.toDouble();
int numToInt(num a) => a.toInt();
String numToString(num a) => a.toString();

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
