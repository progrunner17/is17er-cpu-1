(* helpers *)

open Lexing

type pos = position
type range = pos * pos

let show_pos pos = Printf.sprintf "line %d column %d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
let show_range (pos, pos') = if pos.pos_lnum = pos'.pos_lnum then
		Printf.sprintf "line %d column %d-%d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) (pos'.pos_cnum - pos'.pos_bol + 1)
	else
		Printf.sprintf "line %d column %d - line %d column %d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) pos'.pos_lnum (pos'.pos_cnum - pos'.pos_bol + 1)

let indent = ref 0

let down () = "\n"^String.make !indent ' '
let right () = indent := !indent + 2; ""
let left () = indent := !indent - 2; ""
let down_right () = indent := !indent + 2; down ()
let down_left () = indent := !indent - 2; down ()

let sep s show xs = String.concat s (List.map show xs)
