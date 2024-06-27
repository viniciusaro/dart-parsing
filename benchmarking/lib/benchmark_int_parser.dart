import 'dart:convert';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:parsing/parsing.dart';

const _lipsum = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in libero vitae neque scelerisque auctor. Fusce feugiat laoreet dui at sagittis. Curabitur cursus enim et lacus lacinia rhoncus. Donec non consequat dui. Quisque eleifend augue nec nisl placerat, ac tempus felis maximus. Integer vel mauris quam. Nam vitae turpis ac libero hendrerit vehicula et non nunc. Integer pellentesque ultrices orci, vitae semper enim hendrerit a. Cras ultrices in diam id fringilla. Mauris eget est lectus.

Duis sapien mi, congue sollicitudin ornare id, vestibulum id nisl. Fusce quis condimentum enim. Donec a aliquet sapien. Nullam at nulla at neque faucibus vulputate et nec enim. Phasellus odio ex, blandit quis nulla eget, aliquam pharetra ligula. Donec sollicitudin luctus neque quis varius. Sed laoreet, elit quis accumsan faucibus, ligula nunc consectetur urna, a fermentum felis quam sit amet tortor. Maecenas tristique tortor tincidunt, molestie enim vitae, elementum ante. Donec et fermentum tellus. Curabitur fringilla mi quis erat bibendum pellentesque.

Suspendisse potenti. Mauris mattis lacus a lobortis dignissim. Nullam eu risus id mauris fermentum porta a nec magna. Mauris consectetur, purus et iaculis sagittis, risus sem malesuada elit, sit amet volutpat lacus odio a justo. Suspendisse lectus magna, sagittis sit amet interdum non, cursus at massa. Donec massa massa, finibus nec magna vulputate, facilisis faucibus est. Curabitur quis felis ligula. Aliquam malesuada sapien eu quam convallis accumsan. Mauris iaculis efficitur laoreet. Pellentesque convallis malesuada nunc, vel porttitor turpis vulputate sit amet. In posuere tortor vitae nunc fermentum rutrum. Mauris eget posuere purus, a viverra urna. Vivamus malesuada cursus diam. Sed sagittis imperdiet rutrum.

Nulla id dui in massa vulputate commodo eget et nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum iaculis vestibulum sem, a vehicula justo finibus id. Curabitur sed ullamcorper justo. Cras maximus nibh sed nisl tincidunt pharetra. Morbi fringilla leo in blandit tempus. Interdum et malesuada fames ac ante ipsum primis in faucibus.

Proin placerat, massa id lobortis mollis, velit enim finibus felis, quis imperdiet magna quam eu nisi. Vestibulum leo neque, faucibus nec ante at, interdum porttitor erat. Cras orci lacus, ultricies at dignissim consectetur, ullamcorper eget sem. Integer eu mattis massa. Sed euismod eu mi eu bibendum. Proin viverra volutpat neque facilisis porttitor. Suspendisse vel aliquam urna, laoreet condimentum urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
""";

final _suffix = List.generate(100000, (_) => _lipsum).join("\n");
final _subject = "1234567891234567891$_suffix";
const _intResult = 1234567891234567891;

class BenchmarkIntParserStringPrefix extends BenchmarkBase {
  late IntParser parser;

  BenchmarkIntParserStringPrefix() : super("IntParserStringPrefix");

  @override
  void setup() {
    parser = IntParser();
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(_subject);
    assert(result == _intResult);
    assert(rest == _suffix);
  }
}

class BenchmarkIntParserCodeUnits extends BenchmarkBase {
  late IntParserCodeUnits parser;
  late Iterable<int> iterable;
  late Iterable<int> restIterable;

  BenchmarkIntParserCodeUnits() : super("IntParserCodeUnits");

  @override
  void setup() {
    parser = IntParserCodeUnits();
    iterable = _subject.codeUnits;
    restIterable = _suffix.codeUnits;
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(iterable);
    assert(result == _intResult);
    assert(rest == _suffix.codeUnits);
  }
}

class BenchmarkIntParserCodeUnitsPrefix extends BenchmarkBase {
  late IntParserCodeUnitsPrefix parser;
  late IterableCollection<int> iterable;
  late Iterable<int> restIterable;

  BenchmarkIntParserCodeUnitsPrefix() : super("IntParserCodeUnitsPrefix");

  @override
  void setup() {
    parser = IntParserCodeUnitsPrefix();
    iterable = IterableCollection(_subject.codeUnits);
    restIterable = _suffix.codeUnits;
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(iterable);
    assert(result == _intResult);
    assert(rest.source == _suffix.codeUnits);
  }
}

class BenchmarkIntParserRunesPrefix extends BenchmarkBase {
  late IntParserRunesPrefix parser;
  late IterableCollection<int> iterable;
  late Iterable<int> restIterable;

  BenchmarkIntParserRunesPrefix() : super("IntParserRunesPrefix");

  @override
  void setup() {
    parser = IntParserRunesPrefix();
    iterable = IterableCollection(_subject.runes);
    restIterable = _suffix.runes;
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(iterable);
    assert(result == _intResult);
    assert(rest.source == _suffix.runes);
  }
}

class BenchmarkIntParserBytesPrefix extends BenchmarkBase {
  late IntParserBytesPrefix parser;
  late IterableCollection<int> iterable;
  late Iterable<int> restIterable;

  BenchmarkIntParserBytesPrefix() : super("IntParserBytesPrefix");

  @override
  void setup() {
    parser = IntParserBytesPrefix();
    iterable = IterableCollection(utf8.encode(_subject));
    restIterable = utf8.encode(_suffix);
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(iterable);
    assert(result == _intResult);
    assert(rest.source == restIterable);
  }
}

class BenchmarkIntParserRegex extends BenchmarkBase {
  late IntParserRegex parser;
  late Iterable<int> codeUnits;

  BenchmarkIntParserRegex() : super("IntParserRegex");

  @override
  void setup() {
    parser = IntParserRegex();
    super.setup();
  }

  @override
  void run() {
    final (result, rest) = parser.run(_subject);
    assert(result == _intResult);
    assert(rest == _suffix);
  }
}
