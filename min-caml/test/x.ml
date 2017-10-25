let rec f x y z = x *. y +. (x *. y -. z) *. (x *. y -. z) in
let rec g x y = f x y 2. *. f x y 2. in
let rec h x =
  let rec k x = print_int x; x in
  k x + k x in
print_float (g 3. 5.);
print_float (g 3. 5.);
print_int (h 5);
print_int (h 5)
