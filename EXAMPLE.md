# Example: Parsing race coordinates

This example shows how small, reusable parsers can be composed into a full domain grammar.

## Goal

Parse inputs like:

```
Brasília,
15.793889° S, 47.882778° W,
15.801389° S, 47.900833° W,
...
New York,
40.782865° N, 73.965355° W,
40.748817° N, 73.985428° W
```

---

## Step 1 — Direction signs

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

---

## Step 2 — Latitude and longitude

```dart
final lat = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(northSouthSign)
    .map(multiplyTuple.pipe(numToDouble));

final lng = DoubleParser()
    .skip(StringLiteral("°"))
    .skip(StringLiteral(" "))
    .take(eastWestSign)
    .map(multiplyTuple.pipe(numToDouble));
```

---

## Step 3 — Coordinate

```dart
final coord = lat
    .skip(StringLiteral(","))
    .skip(StringLiteral(" "))
    .take(lng)
    .map(Coordinate.tuple);
```

---

## Step 4 — Cities

```dart
final city = OneOf([
  StringLiteral("Bras")
      .skip(StringLiteralNormalized("í"))
      .skip(StringLiteral("lia"))
      .map((_) => City.bsb),
  StringLiteral("New York").map((_) => City.ny),
  StringLiteral("Amsterdam").map((_) => City.ams),
]);
```

---

## Step 5 — Race

```dart
final race = city
    .skip(StringLiteral(",\n"))
    .take(Many(coord, separator: StringLiteral(",\n")))
    .map(Race.tuple);
```

---

## Step 6 — All races

```dart
final races =
    OneOrMore(race, separator: StringLiteral(",\n"))
        .map(Races.new);
```

---

## Running the parser

```dart
final racesModel = races.run(input.codeUnits);
```

At this point, we are not just parsing strings — we are describing a domain grammar directly in code.

## Full example

See the full example in the [benchmarks](benchmarking/lib/benchmarks/benchmark_coordinate.dart) folder.