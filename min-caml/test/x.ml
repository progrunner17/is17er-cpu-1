if -! ((-! read_int () +@ 3) < int_of_float (5. +@ read_float ()))
then print_int 0 else print_int 1
