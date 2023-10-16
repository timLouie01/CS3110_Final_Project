module type ShipClasses = sig
  
  type t
  val hits : int
  val health : t -> int

end


module Carrier:ShipClasses = struct
  type t = int *int list
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