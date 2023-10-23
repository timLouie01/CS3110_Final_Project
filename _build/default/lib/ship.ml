module type ShipClasses = sig
  
  type t
  (* val hits : int
  
  val non_Hit : int
  val length: int *)
  val health : t -> int
  val move_ship: t -> bool 
  val set_Length : t -> int  -> bool

 
  val build_ship: int -> t




end


module AShip:ShipClasses = struct
  (* Maybe we can have a record whith the hit_pos field corresponding to pos the ship has been hit at
     and the pos list correspoding to int positons that the ship exists at still  -> Represengitn it in this way could help with output interface*)
  (* type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_Ship: string}
  let hits = 0
  let length = 0
  let non_Hit =  0 *)

  type t = {hit_pos:(int*int) list;pos: (int *int) list; type_of_Ship: string; hits : int; length :int ; non_Hit : int}

  let health (ship:t) :int = failwith "unimplemented"

  let set_Length (ship: t) (n :int) = failwith "unimplemented" 
  let build_ship (length:int) : t = failwith "unimplemented" 
  let move_ship: t -> bool = failwith "unimplemented" 
end 

module Carrier:ShipClasses = struct
include AShip

let length = 5

end 


module BattleShip:ShipClasses= struct
  include AShip

  let length = 4
end 

module Destroyer:ShipClasses= struct
  include AShip

  let length = 3
end 

module Submarine:ShipClasses= struct
  include AShip

  let length = 3
end 

module PatrolBoat:ShipClasses= struct
  include AShip

  let length = 2
end 