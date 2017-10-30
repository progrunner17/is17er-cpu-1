(* customized version of Map *)

include Map.S with type key = Id.t

val add_list : (Id.t * 'a) list -> 'a t -> 'a t
val add_list2 : Id.t list -> 'a list -> 'a t -> 'a t
