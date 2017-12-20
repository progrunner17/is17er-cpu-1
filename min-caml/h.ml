(* MATSUSHITA: added helpers *)

open Lexing

let heap_start = 131071

type pos = position
type range = (pos * pos) option
let show_pos pos = Printf.sprintf "%d:%d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
let show_range range = match range with
  | Some (pos, pos') ->
      if pos.pos_lnum = pos'.pos_lnum then
        Printf.sprintf "%d:%d-%d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) (pos'.pos_cnum - pos'.pos_bol + 1)
      else
        Printf.sprintf "%d:%d-%d:%d" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) pos'.pos_lnum (pos'.pos_cnum - pos'.pos_bol + 1)
  | None -> "nowhere"
let show_from_range lines range = match range with
  | Some (pos, pos') ->
    let l = pos.pos_lnum - 1 in
    let l' = pos'.pos_lnum - 1 in
    let c = pos.pos_cnum - pos.pos_bol in
    let c' = pos'.pos_cnum - pos'.pos_bol in
    let line = lines.(l) in
    let line' = lines.(l') in
    Str.global_replace (Str.regexp "\\([ \t\n\r]\\|(\\*.*\\*)\\)+") " " (if l = l' then
      String.sub line c (c' - c)
    else
      String.concat "\n" ([String.sub line c (String.length line - c)]
      @ Array.to_list (Array.sub lines (l + 1) (l' - l - 1))
      @ [String.sub line' 0 c']))
  | None -> "nowhere"
let comment_from_range lines range = match range with
  | None -> ""
  | _ -> " (* "^show_from_range lines range^" *)"

let indent = ref 0
let down () = "\n"^String.make !indent ' '
let right () = indent := !indent + 2; ""
let left () = indent := !indent - 2; ""
let down_right () = indent := !indent + 2; down ()
let down_left () = indent := !indent - 2; down ()

let sep s show xs = String.concat s (List.map show xs)
