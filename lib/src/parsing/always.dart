part of 'parsing.dart';

class Always<Input, A> with Parser<Input, A> {
  final A value;

  Always(this.value);

  @override
  (A, Input) run(Input input) {
    return (value, input);
  }
}
