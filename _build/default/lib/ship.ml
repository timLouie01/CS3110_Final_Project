module type ShipClasses = sig
  
  type t
  val hits : int
  val health : t -> int

end


module Carrier:ShipClasses = struct
  (* Maybe we can have a record whith the hit_pos field corresponding to pos the ship has been hit at
     and the pos list correspoding to int positons that the ship exists at still  -> Represengitn it in this way could help with output interface*)
  type t = {hit_pos:int*int list;pos: int *int list}
  let hits = 0
  let health (ship:t) :int = failwith "unimplemented"
end 


module BattleShip:ShipClasses= struct
  type t = int *int list
  let hits = 0
  let health (ship:t) :int = failwith "unimplemented"
end 

module Destroyer:ShipClasses= struct
  type t = int *int list
  let hits = 0
  let health (ship:t) :int = failwith "unimplemented"
end 

module Submarine:ShipClasses= struct
  type t = int *int list
  let hits = 0
  let health (ship:t) :int = failwith "unimplemented"
end 

module PatrolBoat:ShipClasses= struct
  type t = int *int list
  let hits = 0
  let health (ship:t) :int = failwith "unimplemented"
end 