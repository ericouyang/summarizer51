open Core.Std

module type COMPARABLE =
  sig
    type t
    val compare : t -> t -> float
  end 

module Make (C : COMPARABLE) =
  struct
    let get_summary (text : Parser.sentence list) : string list = 
      ["blah"; "blah"; "blah"]
  end 
