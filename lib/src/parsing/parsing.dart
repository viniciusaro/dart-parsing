import 'package:parsing/fp.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

part 'always.dart';
part 'flat_map.dart';
part 'many.dart';
part 'map.dart';
part 'one_of.dart';
part 'one_or_more.dart';
part 'optional.dart';
part 'parsing_error.dart';
part 'prefix.dart';
part 'skip.dart';
part 'take.dart';

part 'primitives/bool.dart';
part 'primitives/double.dart';
part 'primitives/int.dart';
part 'primitives/string.dart';

typedef CodeUnits = Iterable<int>;

mixin Parser<A, Input> {
  (A, Input) run(Input input) {
    return body().run(input);
  }

  Parser<A, Input> body() {
    return this;
  }
}

extension ParserTransformations<A, Input> on Parser<A, Input> {
  MapParser<A, B, Input> map<B>(B Function(A) transform) {
    return MapParser(this, transform);
  }

  FlatMapParser<A, B, Input> flatMap<B>(
    Parser<B, Input> Function(A) transform,
  ) {
    return FlatMapParser(this, transform);
  }

  TakeParser<A, B, Input> take<B>(Parser<B, Input> other) {
    return TakeParser(this, other);
  }

  TakeUnitParser<A, Input> takeUnit<B>(Parser<Unit, Input> other) {
    return TakeUnitParser(this, other);
  }

  Skip<A, B, Input> skip<B>(Parser<B, Input> other) {
    return Skip(this, other);
  }
}

extension ParserTake3Transformations<A, B, Input> on Parser<(A, B), Input> {
  TakeParser3<A, B, C, Input> take<C>(Parser<C, Input> other) {
    return TakeParser3(this, other);
  }
}

extension ParserTake4Transformations<A, B, C, Input>
    on Parser<(A, B, C), Input> {
  TakeParser4<A, B, C, D, Input> take<D>(Parser<D, Input> other) {
    return TakeParser4(this, other);
  }
}

extension ParserTakeFromUnitTransformations<A, Input> on Parser<Unit, Input> {
  TakeFromUnitParser<A, Input> take<A>(Parser<A, Input> other) {
    return TakeFromUnitParser(this, other);
  }
}
