# dart-parsing

Composable, reusable, and extensible parsers for Dart.

`dart-parsing` is a small parsing library built around a minimal core abstraction. It lets you build expressive parser pipelines through composition, instead of relying on large regular expressions or complex, stateful parsing code.

The main goal is simple: write parsers that look like the grammar they implement.

## Why dart-parsing?

Common parsing approaches usually fall into one of these categories:

- Regular expressions — compact, but hard to read, debug, and extend
- Hand-written parsers — flexible, but often verbose and error-prone
- Parser generators — powerful, but heavyweight and not always idiomatic in Dart

`dart-parsing` focuses on small building blocks that can be composed into larger parsers in a way that stays readable and maintainable.

Key ideas:

- Parsers are easy to combine
- Small parsers can be reused across different grammars
- New behavior comes from composition, not modifying the core
- The resulting code should describe *what* is being parsed, not *how* to move through characters

## Quick example

Here is a small parser that reads a latitude like:

```
15.832373° S
```

```dart
final northSouthSign = OneOf([
  StringLiteral("N").map((_) => 1),
  StringLiteral("S").map((_) => -1),
]);

final lat = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(northSouthSign)
    .map((value, sign) => value * sign);
```

Parsers can then be combined to form larger structures in a way that mirrors the input grammar.

A full example parsing multiple cities and coordinates can be found in **[EXAMPLE.md](EXAMPLE.md)**.

## Performance

Although the library focuses on readability and composability, performance is a first-class concern in the implementation.

Parsers operate directly on the input string using `codeUnits` comparisons rather than creating intermediate substrings. This keeps parsing close to a simple indexed scan over a `String`, which is both predictable and efficient in Dart.

Some of the key performance characteristics:

- **Character-level parsing**  
  Parsers compare integer code units instead of allocating temporary `String` objects.

- **Minimal heap allocations**  
  Most combinators pass indices and lightweight results rather than copying data.

- **No regex engine overhead**  
  Parsing relies on direct control flow instead of a general-purpose regex engine.

- **Composability without abstraction penalty**  
  Even though parsers are built from small units, execution remains close to a linear scan.

## Benchmark

A small benchmark was created to compare different strategies for parsing the same coordinate format:

```
15.832373° S, 47.987751° W
```

Each strategy parsed a large input string containing many concatenated coordinates.

- **Input length:** 269,999,999 characters  
- **Approx. size:** 539,999,998 bytes (UTF-16 code units)  
- Each benchmark ran using the default configuration from the [benchmark_harness](https://pub.dev/packages/benchmark_harness) package.

### Results

| Approach | Total time (µs) |
|----------|-----------------|
| Code unit–based parser | 3,439,030 µs |
| String slice-based parser | 3,524,248.5 µs |
| Regex-based parser | 3,812,673 µs |
| PetitParser | 3,778,925.5 µs |

That corresponds to roughly **3.4–3.8 seconds** to parse ~540 MB of UTF-16 input.

- All approaches complete within the same general performance band, showing that Dart can handle large-scale text parsing efficiently.
- The code unit–based parser is the fastest in this benchmark, while still using fully composable parser building blocks.
- The string slices approach shows similar performance, demonstrating that alternative string-view strategies can also scale well.
- Both the regex engine and PetitParser perform respectably, but come with additional abstraction or engine overhead compared to the direct code unit approach.
- These results reinforce that a composable, declarative parser design can remain competitive even at very large input sizes.

Benchmark results can vary depending on:

- Dart VM warm-up and JIT optimizations  
- Allocation patterns and GC timing  
- Input characteristics (length, structure, failure cases)

The key takeaway is not just which approach is fastest, but that structured, combinator-style parsers can scale to very large inputs while remaining readable and maintainable.

## When to use this

`dart-parsing` works well when:

- You want readable parsing logic written in pure Dart
- You are parsing structured text formats (configs, coordinates, small DSLs, logs, etc.)
- Regular expressions are becoming difficult to maintain
- You want a strongly-typed parsing pipeline

## License

MIT License
