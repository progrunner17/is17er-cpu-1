(* MATSUSHITA: added helpers *)

open Lexing

val heap_start : int

type pos = position
type range = (pos * pos) option
val show_pos : pos -> string
val show_range : range -> string
val show_from_range : string array -> range -> string
val comment_from_range : string array -> range -> string

val down : unit -> string
val right : unit -> string
val left : unit -> string
val down_right : unit -> string
val down_left : unit -> string

val sep : string -> ('a -> string) -> 'a list -> string
