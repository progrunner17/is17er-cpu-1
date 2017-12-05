(*1bit mandelbrot*)
let x = 100 in
let y = 100 in
let rec dbl f = f +. f in
let  cr = dbl (float_of_int x) /. 400.0 -. 1.5 in
let  ci = dbl (float_of_int y) /. 400.0 -. 1.0 in
let rec iloop i zr zi zr2 zi2 cr ci =
  if i = 0 then print_int 1 else
  let tr = zr2 -. zi2 +. cr in
  let ti = dbl zr *. zi +. ci in
  let zr = tr in
  let zi = ti in
  let zr2 = zr *. zr in
  let zi2 = zi *. zi in
  if (2.0 *. 2.0) < (zr2 +. zi2) then print_int 0 else
  iloop (i - 1) zr zi zr2 zi2 cr ci in
  iloop 1000 0.0 0.0 0.0 0.0 cr ci
