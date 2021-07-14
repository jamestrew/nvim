const b = { foo: "bar" };
console.log(b);

const a = (b: number): void | number => {
    if (b === 1) {
        return 4;
    } else if (b === 2) {
        return 5;
    }
    return 2;
};
