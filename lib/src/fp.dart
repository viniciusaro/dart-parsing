import 'dart:core';

///
final unit = const Unit._();

class Unit {
  const Unit._();
}

///
sealed class Optional<A> {
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
  Some(this.value);

  @override
  int get hashCode => value.hashCode ^ 31;
  bool operator ==(Object other) => other is Some<A> && other.value == value;
}

class None<A> extends Optional<A> {
  @override
  int get hashCode => A.hashCode ^ 31;
  bool operator ==(Object other) => other is None<A> && A != dynamic;
}

///
sealed class Result<A, F> {
  A? get value {
    final self = this;
    switch (self) {
      case Success<A, F>():
        return self.value;
      case Failure<A, F>():
        return null;
    }
  }
}

class Success<A, F> extends Result<A, F> {
  final A value;
  Success(this.value);
}

class Failure<A, F> extends Result<A, F> {
  final F failure;
  Failure(this.failure);
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
