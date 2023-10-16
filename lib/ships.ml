open Ship
module type PlayerListOfShips = sig

  type t

  val remove_Carrier: Carrier.t -> bool

end

module Player1List:PlayerListOfShips = struct

  type t = Carrier.t | BattleShip.t | Destroyer.t | Submarine.t | PatrolBoat.t

  let remove_Carrier (input: Carrier.t) : bool 
  = failwith "unimplemented"


end