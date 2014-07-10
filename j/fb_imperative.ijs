FB =: 3 : 0
x =: 1
p =: 0$0
while. x < 101 do.
  if. 0=15|x do.
    p =: p,<'FizzBuzz'
  elseif. 0=3|x do.
    p =: p,<'Fizz'
  elseif. 0=5|x do.
    p =: p,<'Buzz'
  elseif. 1 do.
    p =: p,<":x
  end.
  x =: x + 1
end.
>p
)

