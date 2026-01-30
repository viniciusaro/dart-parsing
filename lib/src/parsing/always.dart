part of 'parsing.dart';

class Always<A, Input> with Parser<A, Input> {
  final A value;

  Always(this.value);

  @override
  (A, Input) run(Input input) {
    return (value, input);
  }
}
