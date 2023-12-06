module type ShipClasses = sig
  type t

  val get_health : t -> int
  val get_length : t -> int
  val get_type_of_ship : t -> string
  val get_hits : t -> int
  val build_ship : string -> t
  (* val set_position : t -> int -> int -> int -> int -> unit *)
  val set_position : t -> int -> int -> int -> int -> ((int * int) * bool) list
  val hit_ship : t -> int * int -> int
  (* val move_ship : t -> bool *)
  val get_sunk : t -> bool
  (* val set_sunk : t -> t  *)

  val get_pos : t -> int -> int -> bool

end 

module AShip : ShipClasses = struct
  (* Maybe we can have a record whith the hit_pos field corresponding to pos the
     ship has been hit at and the pos list correspoding to int positons that the
     ship exists at still -> Representing it in this way could help with output
     interface*)
  (* type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_ship:
     string} let hits = 0 let length = 0 let non_Hit = 0 *)

  type t = {
    mutable position : ((int * int) * bool) list;
    type_of_ship : string;
    mutable hits : int;
    length : int;
    mutable sunk : bool
  }

  let get_health (ship : t) : int = ship.length - ship.hits
  let get_length (ship : t) : int = ship.length
  let get_type_of_ship (ship : t) : string = ship.type_of_ship
  let get_hits (ship : t) : int = ship.hits

  let build_helper (name : string) (length1 : int) (sunk1 : bool) : t =
    { position = []; type_of_ship = name; hits = 0; length = length1; sunk = sunk1}

  let build_ship (name : string) : t =
    match name with
    | "Carrier" ->
        let length = 5 in
        build_helper name length false
    | "Battleship" ->
        let length = 4 in
        build_helper name length false
    | "Destoryer" ->
        let length = 3 in
        build_helper name length false
    | "Submarine" ->
        let length = 3 in
        build_helper name length false
    | "Patrol Boat" ->
        let length = 2 in
        build_helper name length false
    | _ ->
        let length = 0 in
        build_helper name length false

  let rec position_v (s : t) (x : int) (y1 : int) (y2 : int) :
      ((int * int) * bool) list =
    if y1 = y2 then ((x, y2), false) :: s.position
    else (((x, y1), false) :: s.position) @ position_v s x (y1 - 1) y2

  let rec position_h (s : t) (y : int) (x1 : int) (x2 : int) :
      ((int * int) * bool) list =
    if x1 = x2 then ((x1, y), false) :: s.position
    else (((x1, y), false) :: s.position) @ position_h s y (x1 + 1) x2

  (* let rec set_position (s : t) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
    unit = *)
  let rec set_position (s : t) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
      ((int * int) * bool) list =
    if x1 = x2 then
      let () = s.position <- position_v s x1 (Int.max y1 y2) (Int.min y1 y2) in
      s.position
    else
      let () = s.position <- position_h s y1 (Int.min x1 x2) (Int.max x1 x2) in 
      s.position

  (* Returns true if the ship has sunk. Returns false if the ship has not sunk. *)
  let get_sunk (ship : t) : bool = ship.sunk

  (* (* Returns a copy of the ship with the sunk element set to true. To be called 
     when the ship is sunk *)
  let set_sunk (ship : t) : t = {ship with sunk = true} *)


  (* let rec print_out (pos:(((int * int))*bool) list) : unit = 
    match pos with
    | ((x,y),b)::t -> print_endline(string_of_int(x) ^ ","^ string_of_int(y) ^ " | "); print_out (t) *)

  let hit_ship (s : t) (coor : int * int) : int =

    try (let ship_at = List.assoc coor s.position in if ship_at then get_health s else   
    
    let () = s.hits <- s.hits + 1 in
    let () = s.position <- List.remove_assoc coor s.position in
    let () = s.position <- ((coor, true) :: s.position) in
    if ((get_health s ) = 0) then s.sunk <- true;
    get_health s) 
  with Not_found -> match coor with
      | (x,y) -> let () = print_endline (string_of_int(x) ^ "," ^ string_of_int(y)) in get_health s
    (* if try (List.assoc coor s.position = true) with Not_found -> match coor with *)
      (* | (x,y) -> let () = print_endline (string_of_int(x) ^ "," ^ string_of_int(y)) in true then get_health s
    else
      let () = s.hits <- s.hits + 1 in
      let () = s.position <- List.remove_assoc coor s.position in
      let () = s.position <- ((coor, true) :: s.position) in
      if ((get_health s ) = 0) then s.sunk <- true;
      get_health s *)

  let get_pos (ship: t) (x: int) (y: int) : bool = 
    List.assoc (x,y) ship.position 

end
