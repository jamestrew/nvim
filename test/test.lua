Num = 42  -- All numbers are doubles
-- global variables to be capitalized

S = 'immutable string, global variable'
local t = "double quotes also fine, local variable"

while Num < 50 do
    Num = Num + 1  -- no ++ or +=
end

if Num > 40 then
    print 'over 40'
elseif t ~= 'foo' then
    io.write('print out to stdout')
else
    Line = io.read()  -- reads from stdin
end


foo = unUnknownVariable -- foo = nil
aBoolValue = false

-- Only nil and false are falsy; 0 and '' are true!
if not aBoolValue then print('twas false') end

-- terinary operation
local ans = aBoolValue and 'yes' or 'no' --> 'no'


-- looping
local karlSum = 0
for i = 1, 100 do
    karlSum = karlSum + i
end

for j = 100, 1, -1 do karlSum = karlSum + j end -- reverse loop


----------------------------------------------------
-- 2. Functions.
----------------------------------------------------

function fib(n)
  if n < 2 then return 1 end
  return fib(n - 2) + fib(n - 1)
end

-- Closures and anonymous functions are ok:
function adder(x)
  -- The returned function is created when adder is
  -- called, and remembers the value of x:
  return function (y) return x + y end
end


----------------------------------------------------
-- 3. Tables.
----------------------------------------------------

-- Dict literals have string keys by default:
t = {key1 = 'value1', key2 = false}

-- String keys can use js-like dot notation:
print(t.key1)  -- Prints 'value1'.
t.newKey = {}  -- Adds a new key/value pair.
t.key2 = nil   -- Removes key2 from the table.

-- can also use square brackets to reference a key that's not 'dotable'

-- table iteration
for key, val in pairs(t) do print(key, val) end

-- Superglobals
print(_G['_G'] == _G) -- prints true
