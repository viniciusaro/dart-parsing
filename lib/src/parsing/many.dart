part of 'parsing.dart';

class Many<Input, A> with Parser<Input, List<A>> {
  final Parser<Input, A> upstream;
  final Parser<Input, Unit>? separator;

  Many(this.upstream, {Parser<Input, dynamic>? separator})
      : separator = separator?.map(toUnit);

  @override
  (List<A>, Input) run(Input input) {
    var hasNext = true;
    var isFirst = true;
    var rest = input;
    final List<A> matches = [];

    while (hasNext) {
      Input? beforeSeparatorRest;
      try {
        if (!isFirst) {
          var separatorRest = separator?.run(rest).$2;
          beforeSeparatorRest = rest;
          rest = separatorRest ?? rest;
        }

        var (match, upstreamRest) = upstream.run(rest);
        rest = upstreamRest;
        matches.add(match);
      } catch (_) {
        hasNext = false;
        if (beforeSeparatorRest != null) {
          rest = beforeSeparatorRest;
        }
      }
      isFirst = false;
    }
    return (matches, rest);
  }
}
