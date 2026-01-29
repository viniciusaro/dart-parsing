mixin Parser<A, Input> {
  (A, Input) run(Input input) {
    return body().run(input);
  }

  Parser<A, Input> body() {
    return this;
  }
}
