let rec id x = x in
let rec fst p = let (x, y) = id p in x in
let rec snd p = let (x, y) = p in id y in
let rec calc p = fst p +@ snd p in
print_char (calc (1, 2) + int_of_float (calc (3.0, 4.0)))