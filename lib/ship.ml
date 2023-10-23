module type ShipClasses = sig
  type t

  val get_health: t -> int 
  val get_length :t -> int 
  val get_type_of_Ship : t -> string
  val get_hits :t  -> int

  val build_ship : string -> t
  (* val move_ship : t -> bool *)
end

module AShip : ShipClasses = struct
  (* Maybe we can have a record whith the hit_pos field corresponding to pos the
     ship has been hit at and the pos list correspoding to int positons that the
     ship exists at still -> Represengitn it in this way could help with output
     interface*)
  (* type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_Ship:
     string} let hits = 0 let length = 0 let non_Hit = 0 *)

  type t = {
    hit_pos : (int * int) list;
    pos : (int * int) list;
    type_of_Ship : string;
    hits : int;
    length : int;
  }

  let get_health (ship : t) : int = ship.length - ship.hits
  let get_length (ship : t) : int = ship.length
  let get_type_of_Ship (ship : t) : string = ship.type_of_Ship
  let get_hits (ship : t) : int = ship.hits

  let build_helper (name : string) (length1 : int) : t =
    { hit_pos = []; pos = []; type_of_Ship = name; hits = 0; length = length1 }

  let build_ship (name : string) : t =
    match name with
    | "Carrier" ->
        let length = 5 in
        build_helper name length
    | "Battleship" ->
        let length = 4 in
        build_helper name length
    | "Destoryer" ->
        let length = 3 in
        build_helper name length
    | "Submarine" ->
        let length = 3 in
        build_helper name length
    | "Patrol Boat" ->
        let length = 2 in
        build_helper name length
    | _ ->
        let length = 0 in
        build_helper name length

  (* let move_ship : t -> bool = True *)
end
