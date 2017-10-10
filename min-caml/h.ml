(* helpers *)

let commasep print xs = match xs with
| [] -> ()
| x :: xs' -> print x; List.iter (fun x -> print_string ", "; print x) xs'
