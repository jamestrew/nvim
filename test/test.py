# PERF: fully optimized
# HACK: hmmm, this looks a bit funny
# TODO: What else?
# NOTE: adding a note
# FIX: this need fixing
# WARNING: ???


def test(foo: str, bar: int) -> str:
    """
    This is a string to demonstrate
    {wow} inside

    >>> print('code')
    'code'
    """
    return foo + str(bar)


x = 1 + 1  # hello

if x == 2:
    y = 19 + 3
else:
    pass

# this is a comment


if math.sqrt(y) == 2:
    pass
else:
    potato = True


import math

from argparse import ONE_OR_MORE, _callable, Action


print(math.sqrt(5))


@cool_decorator
class MyClass(object):  # TODO: This thing
    def __init__(self, a, b):
        self._a = a

    def other_func(self):
        return {
            "this": "that",
        }


x = 5


if True:  # {{{
    print("inside of fold")
    # {{{ Some folded text
    # }}}# }}}


test("foo", 2)
