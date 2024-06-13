C Function(A) pipe<A, B, C>(
  B Function(A) f,
  C Function(B) g,
) {
  return (a) => g(f(a));
}

D Function(A) pipe3<A, B, C, D>(
  B Function(A) f,
  C Function(B) g,
  D Function(C) h,
) {
  return (a) => h(g(f(a)));
}
