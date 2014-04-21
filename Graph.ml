open Core.Std

module type GRAPH = 
sig
  type 'b t

  val create : unit -> 'b t

  val add_node : 'b t -> string -> 'b -> unit

  val get_node : 'b t -> string -> 'b

  val fold : 'b t -> init:'c -> f:(key:string -> data:'b -> 'c -> 'c) -> 'c
end


module H = Hashtbl.Make(String)

module HashtblGraph : GRAPH =
struct
  type 'b t = 'b H.t

  val create = H.create

  val add_node = H.add

  val get_node = H.find

  val fold = H.fold
end
