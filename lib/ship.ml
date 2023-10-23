module type ShipClasses = sig
  
  type t
  
  val build_ship: string -> t
  val health : t -> int
  val move_ship: t -> bool 

end


module AShip:ShipClasses = struct
  (* Maybe we can have a record whith the hit_pos field corresponding to pos the ship has been hit at
     and the pos list correspoding to int positons that the ship exists at still  -> Represengitn it in this way could help with output interface*)
  (* type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_Ship: string}
  let hits = 0
  let length = 0
  let non_Hit =  0 *)

  type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_Ship: string; hits : int; length :int}

  let health (ship:t) :int = 
    ship.length - ship.hits

  let build_helper (name: string) (length:int):t =
    {hit_pos = [];pos = []; type_of_Ship = name; hits = 0 ; length = length}
  let build_ship (name:string) : t = 
    match name with
    | "Carrier" -> let length = 5 in build_helper (name) (length)
    | "Battleship"-> let length = 4 in build_helper (name) (length)
    | "Destoryer" -> let length = 3 in build_helper (name) (length)
    | "Submarine" -> let length = 3 in build_helper (name) (length)
    | "Patrol Boat" -> let length = 2 in build_helper (name) (length)
    | _ -> let length = 0 in build_helper (name) (length)

  let move_ship: t -> bool = failwith "unimplemented" 
  
end 


