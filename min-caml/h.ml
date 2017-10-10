(* helpers *)

type pos = Lexing.position

let indent = ref 0

let down () = print_newline (); print_string (String.make !indent ' ')
let right () = indent := !indent + 2
let left () = indent := !indent - 2
let down_right () = right (); down ()
let down_left () = left (); down ()

let sep s print xs = match xs with
| [] -> ()
| x :: xs' -> print x; List.iter (fun x -> print_string s; print x) xs'
