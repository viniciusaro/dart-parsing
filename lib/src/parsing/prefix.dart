part of 'parsing.dart';

mixin Collection<Self, Element> {
  int get length;
  Self prefix(bool Function(Element) predicate);
}

mixin RangeReplaceableCollection<Self, Element> on Collection<Self, Element> {
  Self removeFirst(int count);
}

class Prefix<C extends RangeReplaceableCollection<C, E>, E> with Parser<C, C> {
  final bool Function(E)? predicate;

  Prefix([this.predicate]);

  @override
  (C, C) run(C input) {
    final match = predicate != null ? input.prefix(predicate!) : input;
    final rest = input.removeFirst(match.length);
    return (match, rest);
  }
}

class StringCollection
    implements RangeReplaceableCollection<StringCollection, String> {
  final String source;

  StringCollection(this.source);

  @override
  int get length => source.length;

  @override
  StringCollection prefix(bool Function(String) predicate) {
    var prefix = "";
    for (var i = 0; i < source.length - 1; i++) {
      final candidate = prefix + source.substring(i, i + 1);
      if (predicate(prefix)) {
        prefix = candidate;
      } else {
        break;
      }
    }
    return StringCollection(prefix);
  }

  @override
  StringCollection removeFirst(int count) {
    return StringCollection(source.substring(count));
  }
}

extension StringRangeReplaceable on String {
  StringCollection get collection => StringCollection(this);
}

typedef StringPrefix2 = Prefix<StringCollection, String>;

// class Prefix with Parser<

// mixin Collection<Self extends Collection<Self, Element>, Element>
//     implements Generic<Self, Element> {
//   Self prefix(bool Function(Element) predicate);
//   int get length;
// }

// mixin RangeReplaceableCollection<Element> implements Collection<Element> {
//   RangeReplaceableCollection<Element> removeFirst(int count);
// }

// class Prefix<E> with Parser<RangeReplaceableCollection<E>, Collection<E>> {
//   final bool Function(E) predicate;

//   Prefix(this.predicate);

//   @override
//   (Collection<E>, RangeReplaceableCollection<E>) run(
//     RangeReplaceableCollection<E> input,
//   ) {
//     final match = input.prefix(predicate);
//     final rest = input.removeFirst(match.length);
//     return (match, rest);
//   }
// }

class StringPrefix with Parser<String, String> {
  final String prefix;
  final int group;

  StringPrefix(this.prefix, [this.group = 0]);

  @override
  (String, String) run(String input) {
    final regex = RegExp(prefix);
    final match = regex.matchAsPrefix(input);
    final group = match?.group(this.group);
    if (group == null) {
      throw ParserError(expected: prefix, remainingInput: input);
    }
    final rest = input.substring(group.length, input.length);
    return (group, rest);
  }
}

class StringPrefixUpTo with Parser<String, String> {
  final String token;

  StringPrefixUpTo(this.token);

  @override
  Parser<String, String> body() {
    return StringPrefix(r"([\S\s]*)" + token, 1);
  }
}

class StringPrefixThrough with Parser<String, String> {
  final String token;

  StringPrefixThrough(this.token);

  @override
  Parser<String, String> body() {
    return StringPrefix(r"[\S\s]*" + token);
  }
}


// void main() {
//   final Collection<UserList, User>? collection;
//   //
// }


// class User {
//   final String name;
//   User({required this.name});
// }

// class UserList implements RangeReplaceableCollection<UserList, User> {
//   @override
//   int get length => 1;

//   @override
//   UserList prefix(bool Function(User user) predicate) {
//     return this;
//   }

//   @override
//   UserList removeFirst(int count) {
//     return this;
//   }
// }

// class UserPrefix with Parser<UserList, UserList> {
//   final bool Function(User) predicate;

//   UserPrefix(this.predicate);

//   @override
//   (UserList, UserList) run(UserList input) {
//     final match = input.prefix(predicate);
//     final rest = input.removeFirst(match.length);
//     return (match, rest);
//   }
// }