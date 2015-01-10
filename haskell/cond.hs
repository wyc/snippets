signum 0 = 0
signum x = if x < 0 then -1 else 1

formalSignum 0 = 0
formalSignum x = (/) (abs x) x
