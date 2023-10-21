open Ship
module type PlayerListOfShips = sig

  type t
  (* val setUp:t-> bool *)
end

module Player1List:PlayerListOfShips = struct

  (* type t = Carrier.t | BattleShip.t | Destroyer.t | Submarine.t | PatrolBoat.t *)

  type t = {carrier :Carrier.t ; battleship: BattleShip.t ; destoryer : Destroyer.t ;
   submarine : Submarine.t ; patrolBoat : PatrolBoat.t}


end

module Player2List:PlayerListOfShips = struct

  (* type t = Carrier.t | BattleShip.t | Destroyer.t | Submarine.t | PatrolBoat.t *)

  type t = {carrier :Carrier.t ; battleship: BattleShip.t ; destoryer : Destroyer.t ;
   submarine : Submarine.t ; patrolBoat : PatrolBoat.t}


end