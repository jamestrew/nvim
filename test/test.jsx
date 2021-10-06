import React, { useState } from "react";
const a = { foo: "bar" };
console.log(a.foo);

export const foo = () => {
  const [bar, setBar] = useState("baz");

  return (
    <>
      <div>
        <p>FOO BAR!</p>
      </div>
    </>
  );
};
