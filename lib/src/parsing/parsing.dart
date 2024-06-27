import 'package:collection/collection.dart';
import 'package:parsing/fp.dart';

part 'always.dart';
part 'bool.dart';
part 'double.dart';
part 'flat_map.dart';
part 'int.dart';
part 'many.dart';
part 'map.dart';
part 'one_of.dart';
part 'optional.dart';
part 'parsing_error.dart';
part 'prefix_iterable.dart';
part 'prefix_string.dart';
part 'prefix.dart';
part 'skip.dart';
part 'take.dart';

mixin Parser<Input, A> {
  (A, Input) run(Input input) {
    return body().run(input);
  }

  Parser<Input, A> body() {
    return this;
  }
}

extension ParserTransformations<Input, A> on Parser<Input, A> {
  MapParser<Input, A, B> map<B>(B Function(A) transform) {
    return MapParser(this, transform);
  }

  FlatMapParser<Input, A, B> flatMap<B>(
    Parser<Input, B> Function(A) transform,
  ) {
    return FlatMapParser(this, transform);
  }

  TakeParser<Input, A, B> take<B>(Parser<Input, B> other) {
    return TakeParser(this, other);
  }

  TakeUnitParser<Input, A> takeUnit<B>(Parser<Input, Unit> other) {
    return TakeUnitParser(this, other);
  }

  Skip<Input, A, B> skip<B>(Parser<Input, B> other) {
    return Skip(this, other);
  }
}

extension ParserTake3Transformations<Input, A, B> on Parser<Input, (A, B)> {
  TakeParser3<Input, A, B, C> take<C>(Parser<Input, C> other) {
    return TakeParser3(this, other);
  }
}

extension ParserTake4Transformations<Input, A, B, C>
    on Parser<Input, (A, B, C)> {
  TakeParser4<Input, A, B, C, D> take<D>(Parser<Input, D> other) {
    return TakeParser4(this, other);
  }
}

extension ParserTakeFromUnitTransformations<Input, A> on Parser<Input, Unit> {
  TakeFromUnitParser<Input, A> take<A>(Parser<Input, A> other) {
    return TakeFromUnitParser(this, other);
  }
}
