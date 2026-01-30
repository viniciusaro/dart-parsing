# dart-parsing

Composable, reusable, and extensible parsers for Dart.

`dart-parsing` is a small parsing library built around a minimal core abstraction. It lets you build expressive parser pipelines through composition, instead of relying on large regular expressions or complex, stateful parsing code.

The main goal is simple: write parsers that look like the grammar they implement.

---

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

---

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

---

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

---

## Benchmark

A small benchmark was created to compare different strategies for parsing the same coordinate format:

```
15.832373° S, 47.987751° W
```

Each strategy parsed a large input string (~2,699,999 characters) **10 times**, using the default configuration from the [benchmark_harness](https://pub.dev/packages/benchmark_harness) package.

### Results

| Approach | Total time (µs) for 10 parses |
|----------|-------------------------------|
| Code unit–based parser | 41,267 µs |
| `MutableStringSlice` parser | 40,595 µs |
| Regex-based parser | 40,884 µs |

That corresponds to roughly **~4 ms per full parse** of a ~2.7 MB input string.

These results show that composable parsers can remain in the same performance class as regex-based approaches while providing significantly better structure and readability.

---

## When to use this

`dart-parsing` works well when:

- You want readable parsing logic written in pure Dart
- You are parsing structured text formats (configs, coordinates, small DSLs, logs, etc.)
- Regular expressions are becoming difficult to maintain
- You want a strongly-typed parsing pipeline

---

## Status

This project is still evolving. APIs may change as new composition patterns and use cases appear.

Feedback, issues, and contributions are welcome.

---

## License

MIT License
