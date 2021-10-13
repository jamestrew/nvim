const b = { foo: "bar" };
console.log(b);

const a = (b: number): void | number => {
  if (b === 1) {
    return 4;
  } else if (b === 2 && foo) {
    return 5;
  }
  return 2;
};

const c = (): string => {
  const baz: int = b.bar;
  return false;
};
