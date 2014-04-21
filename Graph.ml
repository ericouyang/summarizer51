open Core.Std

module type GRAPH = 
sig
  type 'b t

  val create : (string, unit -> 'b t) Core_kernel.Hash_set_intf.create_options_without_hashable

  val add_node : 'b t -> key:string -> data:'b -> [ `Duplicate | `Ok ]

  val get_node : 'b t -> string -> 'b option

  val fold : 'b t -> init:'c -> f:(key:string -> data:'b -> 'c -> 'c) -> 'c
end

module HashtblGraph : GRAPH =
struct
  module H = Hashtbl.Make(String)

  type 'b t = 'b H.t

  let create = H.create

  let add_node = H.add

  let get_node = H.find

  let fold = H.fold
end
