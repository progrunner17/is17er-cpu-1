let rec f x =
	(if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40) + 100 in
print_int (f 10)
