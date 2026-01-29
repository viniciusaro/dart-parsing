import 'parser.dart';
import 'prefix.dart';
import 'string.dart';

class IntParser with Parser<int, StringSlice> {
  @override
  (int, StringSlice) run(StringSlice input) {
    final parser = Prefix<int>((unit) => unit >= 48 && unit <= 57);
    final (result, rest) = parser.run(input.iterable);
    final intResult = int.parse(String.fromCharCodes(result));
    final stringRest = StringSlice(String.fromCharCodes(rest));
    return (intResult, stringRest);
  }
}
