open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of list of ships *)
  type t = {carrier :Carrier.t ; battleship: BattleShip.t ; destoryer : Destroyer.t ;
  submarine : Submarine.t ; patrolBoat : PatrolBoat.t}

  val build_List : AShip.t list -> t


end

module Player1List:PlayerListOfShips
