open Ship
module type PlayerListOfShips = sig

  type t = {carrier :Carrier.t ; battleship: BattleShip.t ; destoryer : Destroyer.t ;
  submarine : Submarine.t ; patrolBoat : PatrolBoat.t}
  val build_List : AShip.t list -> t

end

module Player1List:PlayerListOfShips = struct

  type t = {carrier :Carrier.t ; battleship: BattleShip.t ; destoryer : Destroyer.t ;
  submarine : Submarine.t ; patrolBoat : PatrolBoat.t}

  let ship_bag = {carrier = Carrier.t ; battleship = BattleShip.t ; destoryer = Destroyer.t ;
  submarine = Submarine.t ; patrolBoat = PatrolBoat.t}

  (* let build_List (ship_Bag:t)(ship: AShip.t): t =
    ship_Bag.ship.type_of_Ship *)


end