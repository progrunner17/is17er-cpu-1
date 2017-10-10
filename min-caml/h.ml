(* helpers *)

let indent = ref 0

let down () = print_newline (); print_string (String.make !indent ' ')
let right () = indent := !indent + 2
let left () = indent := !indent - 2
let down_right () = right (); down ()
let down_left () = left (); down ()

let commasep print xs = match xs with
| [] -> ()
| x :: xs' -> print x; List.iter (fun x -> print_string ", "; print x) xs'
