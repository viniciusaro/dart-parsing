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

`dart-parsing` takes a different approach. It focuses on small building blocks that can be composed into larger parsers in a way that stays readable and maintainable.

Key ideas:

- Parsers are easy to combine
- Small parsers can be reused across different grammars
- New behavior comes from composition, not modifying the core
- The resulting code should describe *what* is being parsed, not *how* to move through characters

---

## Example: parsing geographic coordinates

Suppose we want to parse coordinates like:

```
15.832373° S, 47.987751° W
```

### Direction signs

```dart
final northSouthSign = OneOf([
  StringLiteral("N").map((_) => 1),
  StringLiteral("S").map((_) => -1),
]);

final eastWestSign = OneOf([
  StringLiteral("E").map((_) => 1),
  StringLiteral("W").map((_) => -1),
]);
```

Each of these parsers returns a multiplier for the coordinate value.

---

### Latitude and longitude

```dart
// "15.832373° S"
final lat = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(northSouthSign)
    .map(multiplyTuple.pipe(numToDouble));

// "47.987751° W"
final lng = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(eastWestSign)
    .map(multiplyTuple.pipe(numToDouble));
```

This mirrors the structure of the input: number → degree symbol → space → direction.

---

### A coordinate pair

```dart
// "15.832373° S, 47.987751° W"
final coord = lat
    .skip(StringLiteral(","))
    .skip(StringLiteral(" "))
    .take(lng)
    .map(Coordinate.tuple);
```

---

## Example: parsing race coordinates:

With coordinates building blocks we can implement even more complex parsers:

```dart
final input = """
Brasília,
15.793889° S, 47.882778° W,
15.801389° S, 47.900833° W,
15.789167° S, 47.929722° W,
15.820556° S, 47.864444° W,
15.835278° S, 47.912222° W,
15.775000° S, 47.885556° W,
15.808611° S, 47.952500° W,
New York,
40.782865° N, 73.965355° W,
40.748817° N, 73.985428° W,
40.706086° N, 74.008584° W,
40.730610° N, 73.935242° W,
40.758896° N, 73.985130° W,
40.752726° N, 73.977229° W,
40.689247° N, 74.044502° W"""
```

Each city is followed by multiple coordinate points, which can then be mapped into domain objects.

---

### Parsing races with multiple coordinates

```dart
final city = OneOf([
  StringLiteral("Bras")
      .skip(StringLiteralNormalized("í"))
      .skip(StringLiteral("lia"))
      .map((_) => City.bsb),
  StringLiteral("New York").map((_) => City.ny),
  StringLiteral("Amsterdam").map((_) => City.ams),
]);

final race = city
    .skip(StringLiteral(",\n"))
    .take(Many(coord, separator: StringLiteral(",\n")))
    .map(Race.tuple);

final races =
    OneOrMore(race, separator: StringLiteral(",\n"))
        .map(Races.new);
```

At this point, we are not just parsing strings — we are describing a domain grammar directly in code.

Usage:
```dart
final racesModel = races.run(input.codeUnits);
```

---

## Building blocks

The library is intentionally small, but provides a set of useful primitives:

| Parser | Purpose |
|--------|---------|
| `StringLiteral("text")` | Matches exact text |
| `DoubleParser()` | Parses floating-point numbers |
| `OneOf([...])` | Tries multiple alternative parsers |
| `Many(parser, separator: ...)` | Repeated parser with an optional separator |
| `OneOrMore(parser, separator: ...)` | Like `Many`, but requires at least one match |

And some common combinators:

| Method | Meaning |
|--------|---------|
| `.map(fn)` | Transform the result |
| `.take(other)` | Parse both and keep both results |
| `.skip(other)` | Parse both but discard one side |

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
