module type ShipClasses = sig
  type t

  val get_health : t -> int
  val get_length : t -> int
  val get_type_of_Ship : t -> string
  val get_hits : t -> int
  val build_ship : string -> t
  val set_position : t -> int -> int -> int -> int -> ((int * int) * bool) list
  val hit_ship : t -> int * int -> int
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
    mutable position : ((int * int) * bool) list;
    type_of_Ship : string;
    mutable hits : int;
    length : int;
  }

  let get_health (ship : t) : int = ship.length - ship.hits
  let get_length (ship : t) : int = ship.length
  let get_type_of_Ship (ship : t) : string = ship.type_of_Ship
  let get_hits (ship : t) : int = ship.hits

  let build_helper (name : string) (length1 : int) : t =
    { position = []; type_of_Ship = name; hits = 0; length = length1 }

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

  let rec position_v (s : t) (x : int) (y1 : int) (y2 : int) :
      ((int * int) * bool) list =
    if y1 = y2 then ((x, y2), false) :: s.position
    else (((x, y2), false) :: s.position) @ position_v s x (y1 - 1) y2

  let rec position_h (s : t) (y : int) (x1 : int) (x2 : int) :
      ((int * int) * bool) list =
    if x1 = x2 then ((x1, 2), false) :: s.position
    else (((x1, y), false) :: s.position) @ position_h s y (x1 + 1) x2

  let rec set_position (s : t) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
      ((int * int) * bool) list =
    if x1 = x2 then
      let () = s.position <- position_v s x1 (Int.max y1 y2) (Int.min y1 y2) in
      s.position
    else
      let () = s.position <- position_h s y1 (Int.min x1 x2) (Int.max x1 x2) in
      s.position

  let hit_ship (s : t) (coor : int * int) : int =
    if List.assoc coor s.position = true then get_health s
    else
      let () = s.hits <- s.hits + 1 in
      let () = s.position <- List.remove_assoc coor s.position in
      let () = s.position <- (coor, true) :: s.position in
      get_health s
end
